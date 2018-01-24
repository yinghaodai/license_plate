function threshim = thresholdimage3(image)
hsvimage = rgb2hsv(image);
thresh2 = hsvimage(:,:,2) > 0.4;
thresh3 = (image(:,:,3) < image(:,:,2) - 10) & (image(:,:,2) > 80);
thresh4 = (image(:,:,1) > 100);
threshim = thresh2 & thresh3 & thresh4;