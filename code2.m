path='E:\\学习资料\\数字图像处理\\第三次作业\\第3-次作业\\img\\';
files = dir(fullfile(path,'*.bmp'));
lengthFiles = length(files);
for i = 1:lengthFiles
    [img,map] = imread(strcat(path,files(i).name));%文件所在路径
    disp(strcat(path,files(i).name)) %打印文件路径
    I=ind2gray(img,map);
    
    if(files(i).name=="citywall.bmp")
        hist_citywall=imhist(I);
        continue
    end
    if(files(i).name=="elain.bmp")
        hist_elain=imhist(I);
        continue
    end
    if(files(i).name=="lena.bmp")
        hist_lena=imhist(I);
        continue
    end
    if(files(i).name=="woman.BMP")
        hist_woman=imhist(I);
        continue
    end
    
    if(strfind(files(i).name,'citywall'))
        template=hist_citywall;
    elseif(strfind(files(i).name,'elain'))
        template=hist_elain;
    elseif(strfind(files(i).name,'lena'))
        template=hist_elain;
    elseif(strfind(files(i).name,'woman'))
        template=hist_elain;
    end
            




    subplot(2,2,1);
    %显示一张图片
    imshow(I);
    %加标题在显示后
    title('处理前图像');
    subplot(2,2,2);
    %显示直方图
    imhist(I);
    title('匹配前直方图');
    j=histeq(I,template);
    subplot(2,2,3);
    imshow(j);
    title('匹配后图像');
    subplot(2,2,4);
    imhist(j);
    title('处理后直方图');
    saveas(gcf,[strcat(path,files(i).name,'_匹配'),'.jpg'])
end