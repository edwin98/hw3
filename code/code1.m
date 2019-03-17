path='E:\\学习资料\\数字图像处理\\第三次作业\\第3-次作业\\';
files = dir(fullfile(path,'*.bmp'));
lengthFiles = length(files);
for i = 1:lengthFiles
    [img,map] = imread(strcat(path,files(i).name));%文件所在路径
    disp(strcat(path,files(i).name)) %打印文件路径
    I=ind2gray(img,map);





    subplot(2,2,1);
    %显示一张图片
    imshow(I);
    %加标题在显示后
    title('处理前图像');
    subplot(2,2,2);
    %显示直方图
    imhist(I);
    title('处理前直方图');
    j=histeq(I,256);
    subplot(2,2,3);
    imshow(j);
    title('均衡后图像');
    subplot(2,2,4);
    imhist(j);
    title('处理后直方图');
    saveas(gcf,[strcat(path,files(i).name),'.jpg'])
end