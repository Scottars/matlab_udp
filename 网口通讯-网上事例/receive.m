tic;
u2 = udp('127.0.0.1', 'RemotePort', 8844, 'LocalPort', 8866);
u2.InputBufferSize =8192;
u2.TimeOut=100;
fopen(u2);
u2.DatagramTerminateMode='off';
C=zeros(204,40000);
    for i=1:40000;
        C(:,i)=fread(u2,204,'flozt32');
    end
fclose(u2); 
delete(u2);
clear u2;
toc;