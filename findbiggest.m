function [located, obno, biggest] = findbiggest(threshim)
d = label(closing(threshim,20));
data = measure(d,[],'size');
n = [data.size] > 1500;
located = threshim & 0;
p = find(n);
obno = length(p);
for i = 1:obno
    located = located | d == p(i);
end