function threshim = thresholdimage3(image)
hsvimage = rgb2hsv(image);
thresh2 = hsvimage(:,:,2) > 0.5;
thresh3 = (image(:,:,3) < image(:,:,2) - 20) & (image(:,:,2) > 90);
thresh4 = (image(:,:,3) < 60);
threshim = thresh2 & thresh3 & thresh4;