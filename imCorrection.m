function [pic_Cor] = imCorrection(pic_Ori)
% ������бͼ��
gray=rgb2gray(pic_Ori);
bw=edge(gray,'canny'); % ����Ե
theta=1:180;
[R]=radon(bw,theta);
[~,J]=find(R>=max(max(R)));%J��¼����б��
titAngel=90-J;
pic_Cor=imrotate(pic_Ori,titAngel,'bilinear','crop');
