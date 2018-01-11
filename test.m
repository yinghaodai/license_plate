%Choose testimage: test1/2/6/7/8/9/10/11/12 (3 and 4 have plates removed)
image = imread('test6.png');
[r, c, a] = size(image);
RGBimage = reshape(image,[],3);

%Threshold to colour and size license plate
threshim = thresholdimage(RGBimage,c);
[located, obno] = findbiggest(threshim);

min = measure(located,[],'Minimum');
max = measure(located,[],'Maximum');
xmin = zeros(1,obno);
ymin = zeros(1,obno);
xmax = zeros(1,obno);
ymax = zeros(1,obno);
for i = 1:obno
    xmin(i) = min.minimum(2*i - 1);
    ymin(i) = min.minimum(2*i);
    xmax(i) = max.maximum(2*i -1);
    ymax(i) = max.maximum(2*i);
    cropped = imcrop(image,[xmin(i)-50 ymin(i)-50 xmax(i)-xmin(i)+100 ymax(i)-ymin(i)+100]);
%     figure;
%     imshow(cropped);
end

RGBcropped = reshape(cropped,[],3);
[r2,c2,a2] = size(cropped);
threshcropped = logical(erosion(reshape(((RGBcropped(:,3) < RGBcropped(:,2) - 15) & (RGBcropped(:,2) > 85)),[],c2),3));
imshow(threshcropped);
straightplate = rotateplate(threshcropped);
figure;
imshow(straightplate);
%license plate dimensions 52x11cm