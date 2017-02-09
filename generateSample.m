function generateSample(typeNum)
[FileName,PathName] = uigetfile('Picture\*.png','Select an License Plate image');
pic_Ori = imread([PathName FileName]); % Read the selected image.
pic_Ori = ~im2bw(pic_Ori); % ��ֵ��
figure(1);imshow(imresize(pic_Ori,0.5)) % չʾ
weight = sum(pic_Ori)>0;  % ˮƽͶӰ
height = sum(pic_Ori,2)>0;% ��ֱͶӰ
[wBeg,wEnd] = getPos(weight);% �����Χ
[hBeg,hEnd] = getPos(height);
numChar = length(wBeg)* length(hBeg);%�����ַ���
figure(2)

switch typeNum
    case 1 % if chinese character
        [~,name] = xlsread('Name.xls');
        Sample.type= 'Chinese';
    case 2 % if number and english character
        name = ['1':'9','0','A':'Z'];
        Sample.type= 'number';
end
Sample.out = name;
j = 1;
for i = 1:numChar
    H = ceil(i/length(wBeg));
    W = i-(H-1)*length(wBeg);
    subplot(length(hBeg),length(wBeg),i)
    temp = imAdjust(pic_Ori(hBeg(H)-1:hEnd(H)+1,wBeg(W)-1:wEnd(W)+1),typeNum);
    if temp==0
        continue
    end
    imshow(temp)
    Sample.X(:,:,j) = temp;
    j = j+1;
end
save model_LPR Sample


function [begin,ending] = getPos(sequence)
sequence = diff(sequence);
begin = find(sequence==1);
ending= find(sequence==-1);
if numel(begin)==0;
    begin = 1;
end
if numel(ending)==0;
    ending = length(sequence);
end