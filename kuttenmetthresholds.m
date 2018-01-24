vid = VideoReader('TrainingVideo.avi');
frame = read(vid, 500);
%imwrite(frame,'frametest.png');
plate = '';
plateread = true;
while plateread == true
    image = frame;
    %image = imadjust(image,[0.1 0.1 0.1; 0.8 0.8 0.8],[]);
    figure;
    imshow(image);
    %Threshold to colour license plate, crop out located and straightened license plate
    threshim = thresholdimage3(image);
    %threshim = (image(:,:,3) < image(:,:,2) - 15) & (image(:,:,2) > 85);
    figure;
    imshow(threshim);
    if sum(sum(threshim)) < 1000 %no plate detected at all
        plateread = false;
        break
    end
    cropped = crop(threshim,image,10);
    %hsvcropped = rgb2hsv(cropped);
    low_high = stretchlim(cropped);
    cropped = imadjust(cropped,[0.1 0.1 0.1; 0.7 0.7 0.7]);
    threshcropped = logical((cropped(:,:,3) < cropped(:,:,2)-50) & (cropped(:,:,2) > 120) & (cropped(:,:,1) > 160));
    figure;
    imshow(threshcropped);
    if sum(sum(threshcropped)) < 1000 %object detected too small
        plateread = false;
        break
    end
    straightplate = rotateplate2(threshcropped);
    croppedplate = crop(straightplate,straightplate,-5);
    ratio = length(croppedplate(1,:))/length(croppedplate(:,1));
    volume = length(croppedplate(1,:))*length(croppedplate(:,1));
    if (ratio < 3.75) || (ratio > 6.1) %check license plate proportions
        plateread = false;
        break
    end
    figure;
    imshow(croppedplate);
    %Find and recognise characters in license plate
    labeled = label(opening(~croppedplate,3),1);
    figure;
    imshow(logical(labeled));
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
    plate = zeros(1, 8);
    j = 1;
    %if volume > 30000
        
    for i = 1:6
        index = find(xmin == startpoints(i));
        if (i > 1) && (xmin (index) - xmax(previndex) > 0.05*length(croppedplate(1,:)))
            plate(j) = '-';
            j = j+1;
        end
        character = ~imcrop(logical(allchars),[xmin(index) ymin(index) xmax(index)-xmin(index) ymax(index)-ymin(index)]);
        plate(j) = recognize(character);
        previndex = index;
        j = j+1;
    end
    plate = char(plate);
    plateread = false;
end
disp(plate);
