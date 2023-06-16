function varargout = Main_GUI1(varargin)
% MAIN_GUI1 MATLAB code for Main_GUI1.fig
%      MAIN_GUI1, by itself, creates a new MAIN_GUI1 or raises the existing
%      singleton*.
%
%      H = MAIN_GUI1 returns the handle to a new MAIN_GUI1 or the handle to
%      the existing singleton*.
%
%      MAIN_GUI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_GUI1.M with the given input arguments.
%
%      MAIN_GUI1('Property','Value',...) creates a new MAIN_GUI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_GUI1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_GUI1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main_GUI1

% Last Modified by GUIDE v2.5 18-May-2022 12:15:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_GUI1_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_GUI1_OutputFcn, ...
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


% --- Executes just before Main_GUI1 is made visible.
function Main_GUI1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main_GUI1 (see VARARGIN)

% Choose default command line output for Main_GUI1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main_GUI1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

count = []

% --- Outputs from this function are returned to the command line.
function varargout = Main_GUI1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1

set(handles.radiobutton2,'enable','off')
set(handles.radiobutton3,'enable','off')
set(handles.radiobutton4,'enable','off')
set(handles.radiobutton5,'enable','off')
set(handles.radiobutton6,'enable','off')

load count
idx = 1
count(idx) = count(idx)+1
save count count
set(handles.text2,'string','Voted Successfully !!!')

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2

set(handles.radiobutton1,'enable','off')
set(handles.radiobutton3,'enable','off')
set(handles.radiobutton4,'enable','off')
set(handles.radiobutton5,'enable','off')
set(handles.radiobutton6,'enable','off')

load count
idx = 2
count(idx) = count(idx)+1
save count count
set(handles.text2,'string','Voted Successfully !!!')

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3

set(handles.radiobutton1,'enable','off')
set(handles.radiobutton2,'enable','off')
set(handles.radiobutton4,'enable','off')
set(handles.radiobutton5,'enable','off')
set(handles.radiobutton6,'enable','off')

load count
idx = 3
count(idx) = count(idx)+1
save count count
set(handles.text2,'string','Voted Successfully !!!')

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4

set(handles.radiobutton1,'enable','off')
set(handles.radiobutton2,'enable','off')
set(handles.radiobutton3,'enable','off')
set(handles.radiobutton5,'enable','off')
set(handles.radiobutton6,'enable','off')

load count
idx = 4
count(idx) = count(idx)+1
save count count
set(handles.text2,'string','Voted Successfully !!!')

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5

set(handles.radiobutton1,'enable','off')
set(handles.radiobutton2,'enable','off')
set(handles.radiobutton3,'enable','off')
set(handles.radiobutton4,'enable','off')
set(handles.radiobutton6,'enable','off')

load count
idx = 5
count(idx) = count(idx)+1

save count count
set(handles.text2,'string','Voted Successfully !!!')

% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6

set(handles.radiobutton1,'enable','off')
set(handles.radiobutton2,'enable','off')
set(handles.radiobutton3,'enable','off')
set(handles.radiobutton4,'enable','off')
set(handles.radiobutton5,'enable','off')

load count
idx = 6

count(idx) = count(idx)+1

save count count
set(handles.text2,'string','Voted Successfully !!!')
