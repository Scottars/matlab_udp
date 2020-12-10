function varargout = UDP_receive(varargin)
% UDP_RECEIVE M-file for UDP_receive.fig
%      UDP_RECEIVE, by itself, creates a new UDP_RECEIVE or raises the existing
%      singleton*.
%
%      H = UDP_RECEIVE returns the handle to a new UDP_RECEIVE or the handle to
%      the existing singleton*.
%
%      UDP_RECEIVE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UDP_RECEIVE.M with the given input arguments.
%
%      UDP_RECEIVE('Property','Value',...) creates a new UDP_RECEIVE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UDP_receive_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UDP_receive_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UDP_receive

% Last Modified by GUIDE v2.5 10-Aug-2010 15:46:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UDP_receive_OpeningFcn, ...
                   'gui_OutputFcn',  @UDP_receive_OutputFcn, ...
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


% --- Executes just before UDP_receive is made visible.
function UDP_receive_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UDP_receive (see VARARGIN)

% Choose default command line output for UDP_receive
handles.output = hObject;
ipA='192.168.0.5'; 
portA=8080;
ipB='192.168.0.3';
portB=8080;
handles.udpB=udp(ipA,portA,'LocalPort',portB);
set(handles.udpB,'TimeOut',10);
set(handles.udpB,'InputBufferSize',8192);
fopen(handles.udpB);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UDP_receive wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UDP_receive_OutputFcn(hObject, eventdata, handles) 
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
for t = 1:15
    a1 = str2double(fscanf(handles.udpB));
    set(handles.edit1,'string',a1);
    pause(0.1);
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fclose(handles.udpB);
delete(handles.udpB);
clear ipA portA ipB portB
close();
