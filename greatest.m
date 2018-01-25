function b = greatest(image)
a = label(image);
sizes = measure(a,[],'size');
maxindex = 1;
max = 0;
for i = 1:length(sizes.size)
    if sizes.size(i) > max
        maxindex = i;
        max = sizes.size(i);
    end
end
b = a == maxindex;