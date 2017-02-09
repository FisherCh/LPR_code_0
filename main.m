clear all
close all
clc
[FileName,PathName]=uigetfile('Picture\*.jpg','Select an License Plate image');
pic_Ori=imread([PathName FileName]); % Read the selected image.
figure(1);subplot(2,2,1),imshow(pic_Ori),title('The original picture');
%% Pretreatment of Image.
pic_BW = im2bw(pic_Ori(:,:,3)-pic_Ori(:,:,1),0.3);
% Reduce the noise
pic_BW = medfilt2(double(pic_BW),[5,5]);
pic_BW = im2bw(pic_BW);
subplot(2,2,2),imshow(pic_BW),title('The Binary picture');
Threshold = 5;
% cut the License Plate area.
Level = sum(pic_BW)>Threshold;
subplot(2,2,3);plot(Level);axis([0 length(Level) 0 1])
Level_= find(Level>0);Left = Level_(1); Right = Level_(end);

Vertical = sum(pic_BW,2)>Threshold;
subplot(2,2,4);plot(Vertical);axis([0 length(Vertical) 0 1])
Vertical_= find(Vertical>0);Up = Vertical_(1);Down = Vertical_(end);

Rate = (Right - Left)/(Down - Up);
if 3<Rate && Rate<4.5 % which means that it mere contains one license plate
    License = pic_Ori(Up:Down,Left:Right,:);
    figure(2);subplot(121);imshow(License);title('The original License Plate')
%     [License] = imCorrection(License);
    subplot(122);imshow(License);title('The corrected License')
else
    fprintf('The image may be too noisy or contains more than one objects.\n')
    return
end

%% Character segmentation
% mostly, a chinese License Plate contains 7 characters
License = im2bw(License);
License = medfilt2(double(License),[3,3]); % ÖÐÖµÂË²¨
License = im2bw(License);
position= sum(License)>5;
numChar = 7;
step = round( length(License)/(numChar+0.3) );
figure(3);
theLicense = '0000000';
for i = 1:2
    subChar = License(:,1+(i-1)*step:i*step,:);
    subChar = medfilt2(double(subChar),[5,5]);
    subChar = im2bw(subChar);
    subplot(1,numChar,i)
    imshow(subChar)
    valChar = charIdentify(subChar,i);
    theLicense(i) = valChar;
end
for i = numChar:-1:3
    subChar = License(:,end-(numChar-i+1)*step:end-(numChar-i)*step,:);
    subplot(1,numChar,i)
    imshow(subChar)
    valChar = charIdentify(subChar,2);
    theLicense(i) = valChar;
end
disp(theLicense)