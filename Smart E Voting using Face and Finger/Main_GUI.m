function varargout = Main_GUI(varargin)
% MAIN_GUI MATLAB code for Main_GUI.fig
%      MAIN_GUI, by itself, creates a new MAIN_GUI or raises the existing
%      singleton*.
%
%      H = MAIN_GUI returns the handle to a new MAIN_GUI or the handle to
%      the existing singleton*.
%
%      MAIN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_GUI.M with the given input arguments.
%
%      MAIN_GUI('Property','Value',...) creates a new MAIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main_GUI

% Last Modified by GUIDE v2.5 29-Apr-2023 15:56:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_GUI_OutputFcn, ...
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


% --- Executes just before Main_GUI is made visible.
function Main_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main_GUI (see VARARGIN)

% Choose default command line output for Main_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global I1

% -- Getting Input Image -- %

[f,p] = uigetfile('Face\*.jpg');

if f == 0
    
    warndlg('You Have Cancelled');
    
else
    
    
    I1 = imread([p f]);
    
    axes(handles.axes1);
    
    imshow(I1);
    
    title('Input Face Image','FontName',...
        'Times New Roman','Fontsize',12);
    
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global I2

    [f,p] = uigetfile('Finger\*.jpg');
    
    if f == 0
        
        warndlg('You Have Cancelled');
        
    else
        
        I2 = imread([p f]);
        
    axes(handles.axes2);
        
        imshow(I2);
        
        title('Input Finger Print Image','FontName',...
            'Times New Roman','Fontsize',12);
    end
    
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global I2 I1 IR1 IR2

        IR1 = imresize(I1,[256 256]);
        IR2 = imresize(I2,[256 256]);

        axes(handles.axes3);
        imshow(IR1);
        
        title('Resized Image 1','FontName',...
            'Times New Roman','Fontsize',12);
     
        axes(handles.axes4);

        imshow(IR2);
        
        title('Resized Image 2','FontName',...
            'Times New Roman','Fontsize',12);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IR1 IR2
global LBP_Testfea1 CentroidBif

%  -- Face Detection -- %

bw = im2bw(IR1);

figure('Name','Face Image');
imshow(bw);title('Binary Image');

faceDetector = vision.CascadeObjectDetector();
bbox            = step(faceDetector, IR1);

h = insertObjectAnnotation(IR1,'rectangle',bbox,'Detected Face');
%         figure('Name','Face Image');
axes(handles.axes5);

imshow(h,[])

for i=1:size(bbox,1)
    input2 = imcrop(IR1,bbox(i,:));
    imwrite(input2,['Croped\',num2str(i),'.jpg']);
end


% =======================================================
% Feature Extraction

LBPimg = LBP((input2), [2,3]); % applying local binary pattern
figure
imshow(LBPimg);
title('LBP Image 1');

LBPfeature=imhist(LBPimg); % calculating the histogram features
LBPfea = LBPfeature'; % generating the feature values
LBPfea2 = LBPfea;

LBP_Testfea1 = [LBPfea2];     % Test Feature Generation


% -- Finger (Minutae) -- %

J = im2bw(IR2);
thin_bin_img = bwmorph(~J,'thin','inf');

axes(handles.axes6);

imshow(~thin_bin_img);

title('Thinned Binary Image','FontName',...
    'Times New Roman','Fontsize',12);

fun = @minutie;

Bin_cent = nlfilter(thin_bin_img,[3 3],fun);
% Termination
LTerm = (Bin_cent==1);
figure;
% axes(handles.axes5);

imshow(LTerm);
pause(1);
LTerm_Lab = bwlabel(LTerm);
propTerm = regionprops(LTerm_Lab,'Centroid');
CentroidTerm = round(cat(1,propTerm(:).Centroid));
%         figure(4);
% axes(handles.axes5);
imshow(~Bin_cent);


LTermLab=bwlabel(LTerm);
propTerm=regionprops(LTermLab,'Centroid');
CentroidTerm=round(cat(1,propTerm(:).Centroid));
%         figure(4);
pause(1)
% axes(handles.axes6);
imshow(~Bin_cent);
% -------------------------------------------------------------------------
% set(gcf,'position',[200 40 600 600]);
hold on;
%         figure(4);
% axes(handles.axes6);

title('Finger print Centroid');
plot(CentroidTerm(:,1),CentroidTerm(:,2),'ro');

axes(handles.axes7);

imshow(~Bin_cent);
% set(gcf,'position',[200 40 600 600]);
hold on;
LBif=(Bin_cent==3);
LBifLab=bwlabel(LBif);
propBif=regionprops(LBifLab,'Centroid','Image');
CentroidBif=round(cat(1,propBif(:).Centroid));
hold on;
% figure(5);title('');
plot(CentroidBif(:,1),CentroidBif(:,2),'bo');title('Centroid of Each Ridges');

%         figure(6);
% axes(handles.axes8);

imshow(~Bin_cent);
% set(gcf,'position',[200 40 600 600]);
hold on;
% axes(handles.axes1);
%         figure(6)
plot(CentroidTerm(:,1),CentroidTerm(:,2),'ro');
hold on;
%         figure(6);
% axes(handles.axes8);

plot(CentroidBif(:,1),CentroidBif(:,2),'bo');title('Centroid of Each Ridges');


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global LBP_Testfea1 CentroidBif Testfeature
global Testfea0 Testfea1

set(handles.uitable1,'data',LBP_Testfea1)

set(handles.uitable2,'data',[CentroidBif(1:10) CentroidBif(1:10,2)'])

Testfea2 = [LBP_Testfea1 CentroidBif(1:10) CentroidBif(1:10,2)'];
Testfea0 = [LBP_Testfea1];
Testfea1 = [CentroidBif(1:10) CentroidBif(1:10,2)'];

Testfeature = Testfea2;

figure('Name','Test Features'),

td = uitable('data',Testfeature);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Testfeature
global Testfea0 Testfea1

load Trainfea

% Labels(1:28) = 1;
% Labels(29:30) = 2;
Labels = 1:30;
T1 = Trainfea(:,1:256);
T2 = Trainfea(:,257:276);

Val1 = knnclassify(Testfea0,T1,Labels)
Val2 = knnclassify(Testfea1,T2,Labels)

if Val1 == Val2
    msgbox('Authenticated')
    Main_GUI1
elseif Val1 ~= Val2
    msgbox('Not Authenticated (Not Eligible)')
    
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Main_GUI2


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

count = zeros(1,6);
save count count



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
