function straightplate = rotateplate(threshcropped)
% a = label(threshcropped);
% sizes = measure(a,[],'size');
% biggest = 1;
% max = 0;
% for i = 1:length(sizes.size)
%     if sizes.size(i) > max
%         biggest = i;
%     end
% end
% b = a == i;
mincropped = measure(threshcropped,[],'Minimum');
maxcropped = measure(threshcropped,[],'Maximum');
xminc = mincropped.minimum(1);
yminc = mincropped.minimum(2);
xmaxc = maxcropped.maximum(1);
ymaxc = maxcropped.maximum(2);
yxminc = find(threshcropped(:,xminc+1),1);
xyminc = find(threshcropped(yminc+1,:),1);
yxmaxc = find(threshcropped(:,xmaxc-1),1);
xymaxc = find(threshcropped(ymaxc-1,:),1);
if xyminc > xymaxc
    opp = yxmaxc - ymaxc;
    adj = xmaxc - xymaxc;
    angle = atan(opp/adj);
    straightplate = logical(rotation(threshcropped,-angle,3,'linear','zero'));
else
    opp = yxminc - ymaxc;
    adj = xymaxc - xminc;
    angle = atan(opp/adj);
    straightplate = logical(rotation(threshcropped,angle,3,'linear','zero'));
end