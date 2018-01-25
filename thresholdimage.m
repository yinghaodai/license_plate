function threshim = thresholdimage(RGBimage,c)
thresh1 = RGBimage(:,3) > 1.3*RGBimage(:,1) + 60;
thresh2 = RGBimage(:,3) > RGBimage(:,2) + 42;
thresh3 = (RGBimage(:,3) < RGBimage(:,2) - 30) & (RGBimage(:,2) > 100);
%figure;
%imshow(reshape((thresh1 | thresh2 | thresh3),[],c));
threshim = reshape((thresh1 | thresh2 | thresh3),[],c);
