function recognized = recognize(a)
%a = a(:,:,1);
a = imresize(a, [100 100]);
characters = {'Letters2/B.png' 'Letters2/D.png' 'Letters2/F.png' 'Letters2/G.png' 'Letters2/H.png' 'Letters2/J.png' 'Letters2/K.png' 'Letters2/L.png' 'Letters2/N.png' 'Letters2/P.png' 'Letters2/R.png' 'Letters2/S.png' 'Letters2/T.png' 'Letters2/V.png' 'Letters2/X.png' 'Letters2/Z.png' 'Letters2/0.png' 'Letters2/1.png' 'Letters2/2.png' 'Letters2/3.png' 'Letters2/4.png' 'Letters2/5.png' 'Letters2/6.png' 'Letters2/7.png' 'Letters2/8.png' 'Letters2/9.png'};
%characters = {'Letters/B.png' 'Letters/D.png' 'Letters/F.png' 'Letters/G.png' 'Letters/H.png' 'Letters/J.png' 'Letters/K.png' 'Letters/L.png' 'Letters/N.png' 'Letters/P.png' 'Letters/R.png' 'Letters/S.png' 'Letters/T.png' 'Letters/V.png' 'Letters/X.png' 'Letters/Z.png' 'Numbers/0.png' 'Numbers/1.png' 'Numbers/2.png' 'Numbers/3.png' 'Numbers/4.png' 'Numbers/5.png' 'Numbers/6.png' 'Numbers/7.png' 'Numbers/8.png' 'Numbers/9.png'};
sums = zeros(1,26);
for i = 1:26
    c = logical(imread(char(characters(i))));
    c = c(:,:,1);
    c = imresize(c,[100 100]);
    sums(i) = sum(sum(abs(a - c)));
end
[m, I] = min(sums);
sums(I) = Inf;
[n, J] = min(sums);
name = char(characters(I));
if n - m < 100
%    check whether it should be the first or second (with weights)\
end
recognized = name(end-4);
