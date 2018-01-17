function character = recognize(a)
a = imresize(a, [100 100]);
characters = {'Letters2/B.png' 'Letters2/C.png' 'Letters2/D.png' 'Letters2/F.png' 'Letters2/G.png' 'Letters2/H.png' 'Letters2/J.png' 'Letters2/K.png' 'Letters2/L.png' 'Letters2/N.png' 'Letters2/P.png' 'Letters2/R.png' 'Letters2/S.png' 'Letters2/T.png' 'Letters2/V.png' 'Letters2/X.png' 'Letters2/Z.png' 'Letters2/0.png' 'Letters2/1.png' 'Letters2/2.png' 'Letters2/3.png' 'Letters2/4.png' 'Letters2/5.png' 'Letters2/6.png' 'Letters2/7.png' 'Letters2/8.png' 'Letters2/9.png'};
sums = zeros(1,26);
for i = 1:26
    c = imread(char(characters(i)));
    sums(i) = sum(sum(abs(a - c)));
end
[~,I] = min(sums);
name = characters(I);
character = name(1:end-4);