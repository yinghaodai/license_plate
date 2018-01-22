function plate = test3(image)
plate = '';
plateread = true;
while plateread == true
    %Threshold to colour license plate, crop out located and straightened license plate
    threshim = thresholdimage3(image);
    if sum(sum(threshim)) < 100 %no plate detected at all
        plateread = false;
        break
    end
    cropped = crop(threshim,image,50);
    threshcropped = logical((cropped(:,:,3) < cropped(:,:,2) - 15) & (cropped(:,:,2) > 85));
    if sum(sum(threshcropped)) < 100 %object detected too small
        plateread = false;
        break
    end
    straightplate = rotateplate2(threshcropped);
    croppedplate = crop(straightplate,straightplate,0);
    ratio = length(croppedplate(1,:))/length(croppedplate(:,1));
    volume = length(croppedplate(1,:))*length(croppedplate(:,1));
    if (ratio < 3.75) || (ratio > 5) %check license plate proportions
        plateread = false;
        break
    end
    %Find and recognise characters in license plate
    labeled = label(brmedgeobjs(opening(~croppedplate,3),1));
    if sum(sum(logical(labeled))) < 100 %characters detected too small
        plateread = false;
        break
    end
    sizes = measure(labeled,[],'size');
    if length([sizes.size]) < 6 %not enough characters detected
        plateread = false;
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
    plate = zeros(1, 6);
    for i = 1:6
        index = find(xmin == startpoints(i));
        character = ~imcrop(logical(allchars),[xmin(index) ymin(index) xmax(index)-xmin(index) ymax(index)-ymin(index)]);
        plate(1, i) = recognize(character);
    end
    plate = char(plate);
    plateread = false;
end