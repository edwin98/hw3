path='E:\\ѧϰ����\\����ͼ����\\��������ҵ\\��3-����ҵ\\';
files = dir(fullfile(path,'*.bmp'));
lengthFiles = length(files);
I_all=cell(2,2);
[img,map] = imread(strcat(path,'elain.bmp'));%�ļ�����·��
I=ind2gray(img,map);
I_all{1,1}='elain';
I_all{1,2}=I;
[img,map] = imread(strcat(path,'woman.bmp'));%�ļ�����·��
I=ind2gray(img,map);
I_all{2,1}='woman';
I_resize=imresize(I,0.25);
I_all{2,2}=I_resize;


for num = 1:2
    I=I_all{num,2};

    
    k=0.5;
    masksize = 3; 
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
    I_seg=I;
    mask=I_sub_std<k*I_std;
    I_seg(mask==1)=255;
    I_seg(mask==0)=0;
    mask_f=zeros(m,n);
    for i=1:m
        a=find(I_seg(i,:)==0,1,'first');
        b=find(I_seg(i,:)==0,1,'last');
        mask_f(i,a:b)=1;
    end
    
    
    masksize = 5; 
    exsize = (masksize-1)/2;
    I_sub_sum=zeros(m,n);
    for i = exsize+1:m-exsize-1
        for j = exsize+1:n-exsize-1
            Iex_sub = I_seg(i-exsize:i+exsize, j-exsize:j+exsize);
            I_sub_sum(i,j) = sum(find(Iex_sub==0));
            if(I_sub_sum(i,j)<8)
                I_seg(i,j)=255;
            end
        end
    end
    
    for i=1:n
        a=find(I_seg(:,i)==0,1,'first');
        b=find(I_seg(:,i)==0,1,'last');
        mask_f(a:b,i)=1;
    end
    mask_f=uint8(mask_f);
    I_af=I.*mask_f;
    
    
    figure
    subplot(1,3,1);    
    imshow(I);title('�ָ�ԭʼͼ��');
    subplot(1,3,2);
    imshow(I_seg);title('�ָ��Եͼ��');
    subplot(1,3,3);
    imshow(I_af);title('�ָ��ͼ��')
    saveas(gcf,[strcat(path,I_all{num,1},'_ͼ��ָ�'),'.jpg'])
end