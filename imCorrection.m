function [pic_Cor] = imCorrection(pic_Ori)
% ½ÃÕýÇãÐ±Í¼Ïñ
gray=rgb2gray(pic_Ori);
bw=edge(gray,'canny'); % ¼ì²â±ßÔµ
theta=1:180;
[R]=radon(bw,theta);
[~,J]=find(R>=max(max(R)));%J¼ÇÂ¼ÁËÇãÐ±½Ç
titAngel=90-J;
pic_Cor=imrotate(pic_Ori,titAngel,'bilinear','crop');
