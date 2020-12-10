tic; 
clear;
clc;
for i=1:20;
    for j=1:20;
        for k=1:21;
            data_test_im(i,j,k)=rand;%深度位数据
        end
    end
end
% 
% load('data_test.mat');

s=cell(200,200); %定义待传输的数据
for i=1:20;
    for j=1:20;
        for k=1:21;
            b(k)=data_test_im(i,j,k);%深度位数据
        end
    s(i,j)={[11,i,j,b]};%待传输数据
    end
    
end
u1 = udp('127.0.0.1', 'RemotePort', 8866, 'LocalPort', 8844);%定义udp端口号和ip
u1.OutputBufferSize=8192;%传数据buffer大小
u1.Timeout=1000;%传输时间限制
fopen(u1); 
     for i=1:20;
        for j=1:20;
            aa=s(i,j);
            A=aa{:};
           fwrite(u1,A,'float32'); %传数据
           pause(0.003);
        end
     end
fclose(u1);
delete(u1);
clear u1;
toc;