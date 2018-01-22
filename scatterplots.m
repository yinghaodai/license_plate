%Read in images
lp = imread('lp.png');
noplate1 = imread('frametest.png');
noplate2 = imread('test4.png');

%Reshape to RGB channels
RGBlp = reshape(lp,[],3);
HSVlp = reshape(rgb2hsv(lp),[],3);
RGBnoplate1 = reshape(noplate1,[],3);
HSVnoplate1 = reshape(rgb2hsv(noplate1),[],3);
RGBnoplate2 = reshape(noplate2,[],3);
figure;
scatter3(RGBnoplate1(:,1),RGBnoplate1(:,2),RGBnoplate1(:,3),1,'yellow');
hold on
scatter3(RGBlp(:,1),RGBlp(:,2),RGBlp(:,3),1,'red');
xlabel('red');
ylabel('green');
zlabel('blue');
figure;
scatter(HSVlp(:,1),HSVlp(:,2),1,'yellow');
hold on
scatter(HSVnoplate1(:,1),HSVnoplate1(:,2),1,'red');
%Reshape to RGB channels
% RGBlp = reshape(lp,[],3);
% RGBnoplate1 = reshape(noplate1,[],3);
% RGBnoplate2 = reshape(noplate2,[],3);
% 
% %Scatter plot 1=R 2=G 3=B
% figure;
% scatter(RGBlp(:,2),RGBlp(:,3),1,'yellow');
% hold on;
% scatter(RGBnoplate1(:,2),RGBnoplate1(:,3),1,'red');
% hold on;
% scatter(RGBnoplate2(:,2),RGBnoplate2(:,3),1,'blue');
% x1 = linspace(0,255);
% y1 = x1 + 42;
% plot(x1,y1,'LineWidth',2,'Color','magenta');
% x2=[100,100];
% y2=[0,300];
% plot(x2,y2,'LineWidth',2,'Color','magenta');
% y3 = x1 - 30;
% plot(x1,y3,'LineWidth',2,'Color','magenta');
% xlabel('Green');
% ylabel('Blue');
% title('Green versus blue plot');
% legend('License plate','Car 1','Car 2');
% 
% figure;
% scatter(RGBlp(:,1),RGBlp(:,3),1,'yellow');
% hold on;
% scatter(RGBnoplate1(:,1),RGBnoplate1(:,3),1,'red');
% hold on;
% scatter(RGBnoplate2(:,1),RGBnoplate2(:,3),1,'blue');
% red = linspace(0,255);
% blue2 = 1.3*red + 60;
% plot(red,blue2,'LineWidth',2,'Color','magenta');
% xlabel('Red');
% ylabel('Blue');
% title('Red versus blue plot');
% legend('License plate','Car 1','Car 2');
% 
% figure;
% scatter(RGBlp(:,2),RGBlp(:,1),1,'yellow');
% hold on;
% scatter(RGBnoplate1(:,2),RGBnoplate1(:,1),1,'red');
% hold on;
% scatter(RGBnoplate2(:,2),RGBnoplate2(:,1),1,'blue');
% xlabel('Green');
% ylabel('Red');
% title('Green versus Red plot');
% legend('License plate','Car 1','Car 2');