function straightplate = rotateplate2(threshcropped)
b = greatest(threshcropped);
msr = measure(b,[],{'MajorAxes'},[],Inf,0,0);
angle = msr.majoraxes(2);
straightplate = logical(rotation(threshcropped,angle,3,'nn','zero'));
end