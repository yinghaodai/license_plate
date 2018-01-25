function plate = test3(image)
plate = '';
plateread = true;
while plateread == true
    %Threshold to colour license plate, crop out located and straightened license plate
    threshim = thresholdimage3(image);
    if sum(sum(threshim)) < 1000 %no plate detected at all
        break
    end
    image = crop(threshim,image,3);
    uplim = 0.45;
    avg = mean(mean(mean(image)));
    if  avg> 110
        uplim = 0.75;
    elseif avg > 95
        uplim = 0.68;
    elseif avg > 85
        uplim = 0.60;
    elseif avg > 75
        uplim = 0.52;
    end
    image = imadjust(image,[0.05 0.05 0.05; uplim uplim uplim]);
    thresholded = logical((image(:,:,3) < image(:,:,2)-45) & (image(:,:,2) > 145) & (image(:,:,1) > 165));
    if sum(sum(thresholded)) < 1000 %object detected too small
        break
    end
    cropped = rotateplate2(thresholded);
    cropped = crop(cropped,cropped,-0.02*length(cropped(1,:)));
    ratio = length(cropped(1,:))/length(cropped(:,1));
    %volume = length(cropped(1,:))*length(cropped(:,1));
    if (ratio < 3.75) %check license plate proportions
        break
    end
    %Find and recognise characters in license plate
    labeled = label(closing(~cropped,3));
    if sum(sum(logical(labeled))) < 100 %characters detected too small
        break
    end
    sizes = measure(labeled,[],'size');
    if length([sizes.size]) < 6 %not enough characters detected
        break
    end
    %Find biggest 6 characters on plate (remove hyphens etc)
    sorted = sort([sizes.size],'descend');
    smallest = sorted(6);
    allchars = labeled & 0;
    for i=1:length(sorted)
        if sizes.size(i) >= smallest
            allchars = allchars | labeled == i;
        end
    end
    %calculate dimensions of characters
    [xmin, xmax, ymin, ymax] = deal(zeros(1,6));
    lettermin = measure(allchars,[],'Minimum');
    lettermax = measure(allchars,[],'Maximum');
    for i = 1:6
        xmin(i) = lettermin.Minimum(2*i - 1);
        ymin(i) = lettermin.Minimum(2*i);
        xmax(i) = lettermax.Maximum(2*i - 1);
        ymax(i) = lettermax.Maximum(2*i);
    end
    %sort characters by xmin, recognise
    startpoints = sort(xmin,'ascend');
    plate = zeros(1, 8);
    j = 1;
    %if volume > 30000
        
    for i = 1:6
        index = find(xmin == startpoints(i));
        if (i > 1) && (xmin(index) - xmax(previndex) > 0.05*length(cropped(1,:)))
            plate(j) = '-';
            j = j+1;
        end
        character = ~imcrop(logical(allchars),[xmin(index)+1 ymin(index)+1 xmax(index)-xmin(index) ymax(index)-ymin(index)]);
        plate(j) = recognize(character);
        previndex = index;
        j = j+1;
    end
    plate = char(plate);
    plateread = false;
end