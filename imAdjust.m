function img = imAdjust(img,typeNum)
if nargin==1
    typeNum = 2;
end
if sum(sum(img))<50
    img = 0;
    return
end
if typeNum==1
    weight = sum(img)>0;
    height = sum(img,2)>0;
    [wBeg,wEnd] = getPos(weight);%Çó³ö·¶Î§
    [hBeg,hEnd] = getPos(height);
%     img = img(hBeg(1)-1:hEnd(end)+1,wBeg(1)-1:wEnd(end)+1);
    img = img(hBeg(1):hEnd(end),wBeg(1):wEnd(end));
end
img = imresize(img,[90 90]);


function [begin,ending] = getPos(sequence)
sequence = diff(sequence);

begin = find(sequence==1);
ending= find(sequence==-1);
if numel(begin)==0;
    begin = 1;
end
if numel(ending)==0||(ending(1)<=0.3*length(sequence));
    ending = length(sequence);
end