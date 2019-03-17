path='E:\\ѧϰ����\\����ͼ����\\��������ҵ\\��3-����ҵ\\';
files = dir(fullfile(path,'*.bmp'));
lengthFiles = length(files);
I_all=cell(2,2);
[img,map] = imread(strcat(path,'elain.bmp'));%�ļ�����·��
I=ind2gray(img,map);
I_all{1,1}='elain';
I_all{1,2}=I;
[img,map] = imread(strcat(path,'lena.bmp'));%�ļ�����·��
I=ind2gray(img,map);
I_all{2,1}='lena';
I_all{2,2}=I;


for num = 1:2
    I=I_all{num,2};

    
    k0=0.4;
    k1=0.02;
    k2=0.4;
    E=1.5;
    masksize = 7; 
    exsize = (masksize-1)/2;
    [m,n]=size(I);
    Iex = padarray(I, [exsize exsize], 'replicate', 'both'); 
    I_sub_mean = zeros(m,n); 
    I_sub_std = zeros(m,n);
    for i = 1:m
        for j = 1:n
            Iex_sub = Iex(i:i+2*exsize, j:j+2*exsize);
            I_sub_mean(i,j) = mean2(Iex_sub);
            I_sub_std(i,j)=std2(Iex_sub);
        end
    end
    I_mean=mean2(I);
    I_std=std2(I);
    
    mask=E*((I_sub_mean<k0*I_mean)&(k1*I_std<I_sub_std)&(I_sub_std<k2*I_std));
    mask(find(mask==0))=1;
    mask=uint8(mask);
    I_af=I.*mask;
    figure
    subplot(2,2,1);    
    imshow(I);title('�ֲ���ǿԭʼͼ��');
    subplot(2,2,2);
    imhist(I);title('�ֲ���ǿͼ��ֱ��ͼ')
    subplot(2,2,3);
    imshow(I_af);title('��ǿ��ͼ��');
    subplot(2,2,4);
    imhist(I_af);title('��ǿͼ��ֱ��ͼ');
    saveas(gcf,[strcat(path,I_all{num,1},'_�ֲ���ǿ'),'.jpg'])
end