function varargout = game(varargin)
% game MATLAB code for game.fig
%      game, by itself, creates a new game or raises the existing
%      singleton*.
%
%      H = game returns the handle to a new game or the handle to
%      the existing singleton*.
%
%      game('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in game.M with the given input arguments.
%
%      game('Property','Value',...) creates a new game or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before game_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to game_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help game

% Last Modified by GUIDE v2.5 18-May-2020 08:45:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @game_OpeningFcn, ...
                   'gui_OutputFcn',  @game_OutputFcn, ...
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
end

% --- Executes just before game is made visible.
function game_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to game (see VARARGIN)

% Choose default command line output for game
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes game wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = game_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of pushbutton1 as text
%        str2double(get(hObject,'String')) returns contents of pushbutton1 as a double
end

function game_over(score)
    msg = msgbox(strcat('游戏结束，最终得分：',num2str(score)),'提示信息','modal');%游戏结束后弹出消息框
    msg_ = findobj(msg,'Type','text');
    msg_2 = findobj(msg,'Type','uicontrol');
    msg_3 = findobj(msg,'Type','figure');
    pos=get(msg_3,'Position');
    %定义消息框大小和位置
    pos1=pos(1,1)-150;pos2=pos(1,2);pos3=pos(1,3)+150;pos4=pos(1,4)+20;
    set(msg_3,'Position',[pos1 pos2 pos3 pos4]);
    set(msg_,'FontSize',16,'Unit','normal');
    %set(msg_2,'Position',[85 7 120 28],'FontSize',16,'string','确定');
    set(msg_2,'Position',[85 7 150 22],'FontSize',16,'string','确定');
end
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 向上更新
global data;
data=up_update(data);% 向上更新完成以后
score = sum(sum(data));
if sum(sum(data==0))==0% 若不存在还为0的点，则游戏结束
    data = zeros(size(data));
    game_over(score);% 调用game_over函数
else
    if sum(sum(data)) == 0
        data = zeros(size(data));
    else
        ind2=find(data==0);%随机选取一个取值为0 的点，赋值为2或4
        data(ind2(ceil(rand*length(ind2))))=2+(rand<0.5)*2;
    end
end
axes(handles.axes1);
imagesc(data>=0);
axis off;
hold on 
for i = 1 : size(data, 1)
    for j = 1 : size(data, 2)
        % 标注
        text(j, i, num2str(data(i, j)), 'color', 'k','FontSize',20);
    end
end
hold off
set(handles.edit1,'string',sum(sum(data)))
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 向下更新
global data;
score = sum(sum(data));
data=down_update(data);
if sum(sum(data==0))==0
    data = zeros(size(data));
    game_over(score);
else
    if sum(sum(data)) == 0
        data = zeros(size(data));
    else
        ind2=find(data==0);
        data(ind2(ceil(rand*length(ind2))))=2+(rand<0.5)*2;
    end
end
axes(handles.axes1);
imagesc(data>=0);
axis off;
hold on 
for i = 1 : size(data, 1)
    for j = 1 : size(data, 2)
        % 标注
        text(j, i, num2str(data(i, j)), 'color', 'k','FontSize',20);
    end
end
hold off
set(handles.edit1,'string',sum(sum(data)))
end
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 向左更新
global data;
data=left_update(data);
score = sum(sum(data));
if sum(sum(data==0))==0
    data = zeros(size(data));
    game_over(score);
else
    if sum(sum(data)) == 0
        data = zeros(size(data));
    else
        ind2=find(data==0);
        data(ind2(ceil(rand*length(ind2))))=2+(rand<0.5)*2;
    end
end
axes(handles.axes1);
imagesc(data>=0);
axis off;
hold on 
for i = 1 : size(data, 1)
    for j = 1 : size(data, 2)
        % 标注
        text(j, i, num2str(data(i, j)), 'color', 'k','FontSize',20);
    end
end
hold off
set(handles.edit1,'string',sum(sum(data)))
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 向右更新
global data;
score = sum(sum(data));
data=right_update(data);
if sum(sum(data==0))==0
    data = zeros(size(data));
    game_over(score);
else
    if sum(sum(data)) == 0
        data = zeros(size(data));
    else
        ind2=find(data==0);
        data(ind2(ceil(rand*length(ind2))))=2+(rand<0.5)*2;
    end
end
axes(handles.axes1);
imagesc(data>=0);
axis off;
hold on 
for i = 1 : size(data, 1)
    for j = 1 : size(data, 2)
        % 标注
        text(j, i, num2str(data(i, j)), 'color', 'k','FontSize',20);
    end
end
hold off
set(handles.edit1,'string',sum(sum(data)))
end

% --- Executes on button press in pushbutton6.
% 在start按钮中实现游戏初始化的功能 
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global data;     %定义全局变量data，用来保存游戏进程中各点取值
data=zeros(4,4); %初始化一个4*4矩阵数据（宫格）

%初始化，随机选择两点进行赋值，取值2或4
ind1=ceil(rand(1,4)*4);% 
data(ind1(1),ind1(2))=2+(rand<0.5)*2;
data(ind1(3),ind1(4))=2+(rand<0.5)*2;
%图形显示，调用gui中图形窗口，显示data矩阵
axes(handles.axes1);
imagesc(data>=0);
axis off;%保持宽高比并取消坐标轴
hold on %继续作图
%对每个点标注其取值
for i = 1 : size(data, 1) % 行
    for j = 1 : size(data, 2) %列
        text(j, i, num2str(data(i, j)), 'color', 'k','FontSize',20);%在（i,j)处添加一个字符串data（i,j)
    end
end
hold off%关闭再作图

%调用文本显示窗口edit1，显示当前得分
%set(handles.edit1,'string',sum(data))
set(handles.edit1,'string',sum(sum(data)))
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
end
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
end
