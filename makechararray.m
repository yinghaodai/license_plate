characters = {'Letters2/B.png' 'Letters2/D.png' 'Letters2/F.png' 'Letters2/G.png' 'Letters2/H.png' 'Letters2/J.png' 'Letters2/K.png' 'Letters2/L.png' 'Letters2/N.png' 'Letters2/P.png' 'Letters2/R.png' 'Letters2/S.png' 'Letters2/T.png' 'Letters2/V.png' 'Letters2/X.png' 'Letters2/Z.png' 'Letters2/0.png' 'Letters2/1.png' 'Letters2/2.png' 'Letters2/3.png' 'Letters2/4.png' 'Letters2/5.png' 'Letters2/6.png' 'Letters2/7.png' 'Letters2/8.png' 'Letters2/9.png'};
C = zeros(100,26*50);
for i = 1:26
    c = logical(imread(char(characters(i))));
    c = c(:,:,1);
    c = imresize(c,[100 50]);
    C(1:100,((i-1)*50)+1:(i*50)) = c;
end
C = logical(C);
save('characters.mat','C');