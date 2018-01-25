function straightplate = rotateplate(threshcropped)
eps = 5;
b = greatest(threshcropped);
mincropped = measure(b,[],'Minimum');
maxcropped = measure(b,[],'Maximum');
xmin = mincropped.minimum(1);
ymin = mincropped.minimum(2);
xmax = maxcropped.maximum(1);
ymax = maxcropped.maximum(2);
yxmin = find(threshcropped(:,xmin+1),1);
xymin = find(threshcropped(ymin+1,:),1);
yxmax = find(threshcropped(:,xmax-1),1);
xymax = find(threshcropped(ymax-1,:),1);
if (abs(xmin - xymax) < eps) || (abs(xmin - xymin) < eps)
    straightplate = threshcropped;
elseif xymin > xymax
    opp = yxmax - ymax;
    adj = xmax - xymax;
    angle = atan2(opp,adj);
    straightplate = logical(rotation(threshcropped,-angle,3,'linear','zero'));
else
    opp = yxmin - ymax;
    adj = xymax - xmin;
    angle = atan2(opp,adj);
    straightplate = logical(rotation(threshcropped,angle,3,'linear','zero'));
end