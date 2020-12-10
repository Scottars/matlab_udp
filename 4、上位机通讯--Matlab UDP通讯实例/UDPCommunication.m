function varargout = UDPCommunication(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UDPCommunication_OpeningFcn, ...
                   'gui_OutputFcn',  @UDPCommunication_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function UDPCommunication_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
%=================================
%�������ݶ˵Ĳ�������
ipLocal='127.0.0.1'; %�������ݶ˵�ip�����ص�

portTransmit_Local=9090; %�������ݶ˵Ķ˿ںţ����ص�
ipReceive_Remote='127.0.0.1'; %�������ݶ˵�ip�Ͷ˿ںţ�Զ�˵�
portReceive_Remote=9091;
handles.udpTransmit=udp(ipReceive_Remote,portReceive_Remote,'LocalPort',portTransmit_Local);

%�������ݶ˵Ĳ�������
portReceive_Local=9091; %�������ݶ˵Ķ˿ںţ����ص�
ipTransmit_Remote='127.0.0.1'; %�������ݶ˵�ip�Ͷ˿ںţ�Զ�˵�
portTransmit_Remote=9090;
handles.udpReceive=udp(ipTransmit_Remote,portTransmit_Remote,'LocalPort',portReceive_Local);
%=================================
guidata(hObject, handles);


function varargout = UDPCommunication_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function pushbutton1_Callback(hObject, eventdata, handles)
%���÷������ݶ˻����С���򿪷������ݶ�UDP
set(handles.udpTransmit,'OutputBufferSize',1024);
fopen(handles.udpTransmit);
%================================


function pushbutton2_Callback(hObject, eventdata, handles)
%��������
str=get(handles.edit1,'string');
fprintf(handles.udpTransmit,str);
%================================


function pushbutton3_Callback(hObject, eventdata, handles)
%�رշ������ݶ�UDP
fclose(handles.udpTransmit);
delete(handles.udpTransmit);
clear ipLocal portTransmit_Local ipReceive_Remote portReceive_Remote
%================================


function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton4_Callback(hObject, eventdata, handles)
%���ý������ݶ˻����С���򿪽������ݶ�UDP
set(handles.udpReceive,'InputBufferSize',1024);
fopen(handles.udpReceive);
%=============================


function pushbutton5_Callback(hObject, eventdata, handles)
%��������
str=fscanf(handles.udpReceive);
set(handles.edit2,'string',str);
%=============================


function pushbutton6_Callback(hObject, eventdata, handles)
%�رս������ݶ�UDP
fclose(handles.udpReceive);
delete(handles.udpReceive);
clear ipLocal portReceive_Local ipTransmit_Remote portTransmit_Remote 
%=============================


function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end