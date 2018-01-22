function threshim = thresholdimage2(image)
thresh1 = image(:,:,3) > 1.3*image(:,:,1) + 60;
thresh2 = image(:,:,3) > image(:,:,2) + 42;
thresh3 = (image(:,:,3) < image(:,:,2) - 30) & (image(:,:,2) > 100);
figure;
threshim = thresh1 | thresh2 | thresh3;
