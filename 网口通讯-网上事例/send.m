tic; 
clear;
clc;
for i=1:20;
    for j=1:20;
        for k=1:21;
            data_test_im(i,j,k)=rand;%���λ����
        end
    end
end
% 
% load('data_test.mat');

s=cell(200,200); %��������������
for i=1:20;
    for j=1:20;
        for k=1:21;
            b(k)=data_test_im(i,j,k);%���λ����
        end
    s(i,j)={[11,i,j,b]};%����������
    end
    
end
u1 = udp('127.0.0.1', 'RemotePort', 8866, 'LocalPort', 8844);%����udp�˿ںź�ip
u1.OutputBufferSize=8192;%������buffer��С
u1.Timeout=1000;%����ʱ������
fopen(u1); 
     for i=1:20;
        for j=1:20;
            aa=s(i,j);
            A=aa{:};
           fwrite(u1,A,'float32'); %������
           pause(0.003);
        end
     end
fclose(u1);
delete(u1);
clear u1;
toc;