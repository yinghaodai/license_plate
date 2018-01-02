%Read in images
lp = imread('lp.png');
noplate1 = imread('test3.png');
noplate2 = imread('test4.png');
%Choose testimage: test1/2/4/5/6/7 (3 and 4 have plates removed)
testimage = imread('test2.png');
[r c a] = size(testimage);

%Reshape to RGB channels
RGBlp = reshape(lp,[],3);
RGBnoplate1 = reshape(noplate1,[],3);
RGBnoplate2 = reshape(noplate2,[],3);
RGBtestimage = reshape(testimage,[],3);

%Scatter plot 1=R 2=G 3=B
scatter(RGBlp(:,2),RGBlp(:,3),1,'yellow');
hold on;
scatter(RGBnoplate1(:,2),RGBnoplate1(:,3),1,'red');
hold on;
scatter(RGBnoplate2(:,2),RGBnoplate2(:,3),1,'blue');

%Threshold to colour and size license plate
thresh1 = RGBtestimage(:,2) > 100;
thresh2 = RGBtestimage(:,3) < 70;
threshim = reshape(thresh1 & thresh2,[],c);
d = label(closing(threshim,10));
data = measure(d,[],'size');
n = [data.size] > 200;
newimage = threshim & 0;
plate = find(n);
for i = 1:length(plate)
    newimage = newimage | d == plate(i);
end
newimage