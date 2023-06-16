function varargout = Main_GUI2(varargin)
% MAIN_GUI2 MATLAB code for Main_GUI2.fig
%      MAIN_GUI2, by itself, creates a new MAIN_GUI2 or raises the existing
%      singleton*.
%
%      H = MAIN_GUI2 returns the handle to a new MAIN_GUI2 or the handle to
%      the existing singleton*.
%
%      MAIN_GUI2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_GUI2.M with the given input arguments.
%
%      MAIN_GUI2('Property','Value',...) creates a new MAIN_GUI2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_GUI2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_GUI2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main_GUI2

% Last Modified by GUIDE v2.5 18-May-2022 16:46:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_GUI2_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_GUI2_OutputFcn, ...
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


% --- Executes just before Main_GUI2 is made visible.
function Main_GUI2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main_GUI2 (see VARARGIN)

% Choose default command line output for Main_GUI2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main_GUI2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

load count

set(handles.text8,'string',[num2str(count(1)),' count']);
set(handles.text9,'string',[num2str(count(2)),' count']);
set(handles.text10,'string',[num2str(count(3)),' count']);
set(handles.text11,'string',[num2str(count(4)),' count']);
set(handles.text12,'string',[num2str(count(5)),' count']);
set(handles.text13,'string',[num2str(count(6)),' count']);

% --- Outputs from this function are returned to the command line.
function varargout = Main_GUI2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
