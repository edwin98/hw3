path='E:\\ѧϰ����\\����ͼ����\\��������ҵ\\��3-����ҵ\\';
files = dir(fullfile(path,'*.bmp'));
lengthFiles = length(files);
for i = 1:lengthFiles
    [img,map] = imread(strcat(path,files(i).name));%�ļ�����·��
    disp(strcat(path,files(i).name)) %��ӡ�ļ�·��
    I=ind2gray(img,map);





    subplot(2,2,1);
    %��ʾһ��ͼƬ
    imshow(I);
    %�ӱ�������ʾ��
    title('����ǰͼ��');
    subplot(2,2,2);
    %��ʾֱ��ͼ
    imhist(I);
    title('����ǰֱ��ͼ');
    j=histeq(I,256);
    subplot(2,2,3);
    imshow(j);
    title('�����ͼ��');
    subplot(2,2,4);
    imhist(j);
    title('�����ֱ��ͼ');
    saveas(gcf,[strcat(path,files(i).name),'.jpg'])
end