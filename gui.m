function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 10-Jan-2018 10:40:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)
axes(handles.imageAxes)
title = imread('Title.jpeg');
image(title)
axis off
axis image
data = cell(0, 3);
set(handles.outputTable, 'Data', data);
handles.completeData = cell(5000, 3);
handles.counter = 0;

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in selectVideo.
function selectVideo_Callback(hObject, eventdata, handles)
% hObject    handle to selectVideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, ~, ~] = uigetfile('*.avi', 'Select your video file');
handles.vid = VideoReader(filename); % Create a VideoReader object
guidata(hObject, handles);
axes(handles.axes); % switch focus to axes
frame = read(handles.vid, 1); % read the first frame
image(frame); % display first frame in axes

% --- Executes on button press in processVideo.
function processVideo_Callback(hObject, eventdata, handles)
% hObject    handle to processVideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
temp = cell(10, 3);
tempCount = 0;
for i = 1:handles.vid.NumberOfFrames
	frame = read(handles.vid, i); % read the i-th frame
	image(frame); % display image in axes
    
    %%%%%%%%%%%%%%%%%%%%%%%
    try
        licensePlate = processImage(frame);
    catch
        licensePlate = '';
    end;
    %%%%%%%%%%%%%%%%%%%%%%%
    
    if size(licensePlate, 2) > 0
%         newData = [{char(licensePlate)}, {i}, {i/handles.vid.Framerate}];
        
        if ismember(char(licensePlate), temp(1:tempCount, 1))
            [~, index] = ismember(char(licensePlate), temp(1:tempCount, 1));
            temp{index, 3} = temp{index, 3} + 1;
%             if temp{index, 3} == 13
%                 data = [temp(index, 1), temp(index, 2), {temp{index, 2}/handles.vid.Framerate}];
%                 handles.counter = handles.counter + 1;
%                 handles.completeData(handles.counter, :) = data;
%                 if handles.counter > 12
%                     set(handles.outputTable, 'Data', handles.completeData(handles.counter-11:handles.counter, :));
%                 else
%                     set(handles.outputTable, 'Data', handles.completeData(1:handles.counter, :));
%                 end
%                 guidata(hObject, handles);
%             end
        elseif tempCount == 0 || (size(temp{tempCount, 1}, 2) == size(char(licensePlate), 2) && strdist(temp{tempCount, 1}, char(licensePlate)) < 3)
            tempCount = tempCount + 1;
            temp{tempCount, 1} = char(licensePlate);
            temp{tempCount, 2} = i;
            temp{tempCount, 3} = 1;
        else
            [~, index] = max([temp{1:tempCount, 3}]);
            data = [temp(index, 1), temp(index, 2), {temp{index, 2}/handles.vid.Framerate}];
            handles.counter = handles.counter + 1;
            handles.completeData(handles.counter, :) = data;
            if handles.counter > 12
                set(handles.outputTable, 'Data', handles.completeData(handles.counter-11:handles.counter, :));
            else
                set(handles.outputTable, 'Data', handles.completeData(1:handles.counter, :));
            end
            guidata(hObject, handles);
            tempCount = 1;
            temp{tempCount, 1} = char(licensePlate);
            temp{tempCount, 2} = i;
            temp{tempCount, 3} = 1;
        end
        
%         handles.counter = handles.counter + 1;
%         handles.completeData(handles.counter, :) = newData;
%         if handles.counter > 12
%             set(handles.outputTable, 'Data', handles.completeData(handles.counter-11:handles.counter, :));
%         else
%             set(handles.outputTable, 'Data', handles.completeData(1:handles.counter, :));
%         end
%         guidata(hObject, handles);
    end
end
toc
if tempCount > 0
    [~, index] = max([temp{1:tempCount, 3}]);
    data = [temp(index, 1), temp(index, 2), {temp{index, 2}/handles.vid.Framerate}];
    handles.counter = handles.counter + 1;
    handles.completeData(handles.counter, :) = data;
    if handles.counter > 12
        set(handles.outputTable, 'Data', handles.completeData(handles.counter-11:handles.counter, :));
    else
        set(handles.outputTable, 'Data', handles.completeData(1:handles.counter, :));
    end
    guidata(hObject, handles);
end
handles.completeData = handles.completeData(1:handles.counter, :);
checkSolution(handles.completeData, 'trainingsolutions.mat');


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: delete(hObject) closes the figure
handles.completeData = handles.completeData(1:handles.counter, :);
checkSolution(handles.completeData, 'trainingsolutions.mat');
delete(hObject);
