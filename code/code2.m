path='E:\\ѧϰ����\\����ͼ����\\��������ҵ\\��3-����ҵ\\img\\';
files = dir(fullfile(path,'*.bmp'));
lengthFiles = length(files);
for i = 1:lengthFiles
    [img,map] = imread(strcat(path,files(i).name));%�ļ�����·��
    disp(strcat(path,files(i).name)) %��ӡ�ļ�·��
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
    %��ʾһ��ͼƬ
    imshow(I);
    %�ӱ�������ʾ��
    title('����ǰͼ��');
    subplot(2,2,2);
    %��ʾֱ��ͼ
    imhist(I);
    title('ƥ��ǰֱ��ͼ');
    j=histeq(I,template);
    subplot(2,2,3);
    imshow(j);
    title('ƥ���ͼ��');
    subplot(2,2,4);
    imhist(j);
    title('�����ֱ��ͼ');
    saveas(gcf,[strcat(path,files(i).name,'_ƥ��'),'.jpg'])
end