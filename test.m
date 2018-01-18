%Choose testimage: test1/2/6/7/8/9/10/11/12 (3 and 4 have plates removed)
image = imread('testya19.png');
figure;
imshow(image);
[r, c, ~] = size(image);
RGBimage = reshape(image,[],3);

%Threshold to colour and size license plate
threshim = thresholdimage(RGBimage,c);
cropped = crop(threshim,image,50);
RGBcropped = reshape(cropped,[],3);
[r2,c2,~] = size(cropped);
threshcropped = logical(erosion(reshape(((RGBcropped(:,3) < RGBcropped(:,2) - 15) & (RGBcropped(:,2) > 85)),[],c2),3));

straightplate = rotateplate2(threshcropped);
croppedplate = crop(straightplate,straightplate,0);
letters = label(brmedgeobjs(~closing(croppedplate,5),1));

lettersize = measure(letters,[],'size');
sorted = sort([lettersize.size],'descend');
smallest = sorted(6);
a = letters & 0;
for i=1:length(sorted)
    if lettersize.size(i) >= smallest
        a = a | letters == i;
    end
end
figure;
imshow(logical(letters));
xmin = zeros(1,6);
xmax = zeros(1,6);
ymin = zeros(1,6);
ymax = zeros(1,6);
lettermin = measure(a,[],'Minimum');
lettermax = measure(a,[],'Maximum');
sorted2 = zeros(1,6);
for i = 1:6
    xmin(i) = lettermin.Minimum(2*i - 1);
    sorted2(i) = xmin(i);
    ymin(i) = lettermin.Minimum(2*i);
    xmax(i) = lettermax.Maximum(2*i - 1);
    ymax(i) = lettermax.Maximum(2*i);
end
sorted3 = sort(sorted2,'ascend');
 for i = 1:6
     index = find(sorted2 == sorted3(i));
     character = ~imcrop(logical(a),[xmin(index) ymin(index) xmax(index)-xmin(index) ymax(index)-ymin(index)]);
     figure;
     imshow(character);
     disp(recognize(character));
 end
%license plate dimensions 52x11cm