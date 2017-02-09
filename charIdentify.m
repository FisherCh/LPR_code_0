function valChar = charIdentify(img,kind)
% �Աȵõ��ַ�
if kind == 1
    load('model_LPR_zh.mat')
elseif kind == 2
    load('model_LPR_num.mat')
end

times = length(Sample.out); % ��ȽϵĴ���
% img = imAdjust(img,kind);
img = imAdjust(img,1);
code = Hash(img);
err  = zeros(1,times);
for i = 1:times
    code_ = Sample.X(:,:,i);
    code_ = Hash(code_);
    err(i) = sum((code-code_).^2);
end
[val,pos] = min(err);

valChar = Sample.out(pos);
if kind == 1
    valChar = valChar{1};
end

function code = Hash(img)
numBlock = 5;
step = 90/numBlock;
code = zeros(numBlock,numBlock);
% img = bwmorph(img,'thin',2); % ϸ��
for i = 1:numBlock
    for j = 1:numBlock
        code(i,j) = sum(sum(img(1+(i-1)*step:i*step,1+(j-1)*step:j*step)));
    end
end
code = code(:);