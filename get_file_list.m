function file_list = get_file_list(direct, format)
% 获取文件夹下特定格式的文件的列表
if nargin == 1
    format = '*.jpg';
end
Direct = dir([direct,format]);
num = length( Direct );
file_list = cell(num,1);
for i = 1:num
    file_list{i} = [direct Direct(i).name];
end