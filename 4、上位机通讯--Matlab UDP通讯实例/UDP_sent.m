function varargout = UDP_sent(varargin)
% UDP_SENT M-file for UDP_sent.fig
%      UDP_SENT, by itself, creates a new UDP_SENT or raises the existing
%      singleton*.
%
%      H = UDP_SENT returns the handle to a new UDP_SENT or the handle to
%      the existing singleton*.
%
%      UDP_SENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UDP_SENT.M with the given input arguments.
%
%      UDP_SENT('Property','Value',...) creates a new UDP_SENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UDP_sent_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UDP_sent_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UDP_sent

% Last Modified by GUIDE v2.5 10-Aug-2010 10:56:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UDP_sent_OpeningFcn, ...
                   'gui_OutputFcn',  @UDP_sent_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before UDP_sent is made visible.
function UDP_sent_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UDP_sent (see VARARGIN)

% Choose default command line output for UDP_sent
handles.output = hObject;

ipA = '192.168.0.5'; 
portA = 8080;
ipB = '192.168.0.3';
portB = 8080;
handles.udpA = udp(ipB,portB,'LocalPort',portA);
set(handles.udpA,'OutputBufferSize',8192);
set(handles.udpA,'TimeOut',100);
fopen(handles.udpA);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UDP_sent wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UDP_sent_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for t = 1:100
    x = sin(t);
    set(handles.edit1,'String',x);
    v1=str2double(get(handles.edit1,'string'));
    w1(t)=v1;
    fprintf(handles.udpA,v1);
    pause(0.1);
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fclose(handles.udpA);
delete(handles.udpA);
clear ipA portA ipB portB
close();
