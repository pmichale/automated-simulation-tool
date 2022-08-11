% Rozhrani pro pripojeni
% Dependence: mysql8con.m, mysql57con.m, postgresqlcon.m, MSSQLconALT.m,
% Dependence: MSSQLcon.m, mssql-jdbc-8.2.2.jre8.jar, mysql-connector-java-5.1.48.jar 
% Dependence: mysql-connector-java-8.0.20.jar, postgresql-42.2.14.jar
% Petr Michalek

function varargout = conn(varargin)
% CONN MATLAB code for conn.fig
%      CONN, by itself, creates a new CONN or raises the existing
%      singleton*.
%
%      H = CONN returns the handle to a new CONN or the handle to
%      the existing singleton*.
%
%      CONN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONN.M with the given input arguments.
%
%      CONN('Property','Value',...) creates a new CONN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before conn_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to conn_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help conn

% Last Modified by GUIDE v2.5 22-Jun-2020 14:49:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @conn_OpeningFcn, ...
                   'gui_OutputFcn',  @conn_OutputFcn, ...
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


% --- Executes just before conn is made visible.
function conn_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to conn (see VARARGIN)

% Choose default command line output for conn
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes conn wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = conn_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in menu_DBtype.
function menu_DBtype_Callback(hObject, eventdata, handles)
% hObject    handle to menu_DBtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menu_DBtype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menu_DBtype

% volba = get(handles.menu_DBtype,'Value');
volba = get(hObject,'Value');
switch volba
    case {2}
        DBtyp='MyS8';
        setappdata(handles.menu_DBtype, 'DBtyp', DBtyp);
        set(handles.conn_port, 'String', '3306');
        port = '3306';
        setappdata(handles.conn_port, 'port', 3306);
        
    case {3}
        DBtyp='MyS57';
        setappdata(handles.menu_DBtype, 'DBtyp', DBtyp);
        set(handles.conn_port, 'String', '3306');
        port = '3306';
        setappdata(handles.conn_port, 'port', port);

    case {4}
        DBtyp='Post';
        setappdata(handles.menu_DBtype, 'DBtyp', DBtyp);
        set(handles.conn_port, 'String', '5432');
        port = '5432';
        setappdata(handles.conn_port, 'port', port);

    
    case {5}
        DBtyp='MSSQL';
        setappdata(handles.menu_DBtype, 'DBtyp', DBtyp);
        set(handles.conn_port, 'String', '1433');
        port = '1433';
        setappdata(handles.conn_port, 'port', 1433);
    
end




% --- Executes during object creation, after setting all properties.
function menu_DBtype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu_DBtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function conn_address_Callback(hObject, eventdata, handles)
% hObject    handle to conn_address (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of conn_address as text
%        str2double(get(hObject,'String')) returns contents of conn_address as a double
adresa = get(hObject,'String');
setappdata(handles.conn_address, 'adresa', adresa);


% --- Executes during object creation, after setting all properties.
function conn_address_CreateFcn(hObject, eventdata, handles)
% hObject    handle to conn_address (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function conn_port_Callback(hObject, eventdata, handles)
% hObject    handle to conn_port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of conn_port as text
%        str2double(get(hObject,'String')) returns contents of conn_port as a double
port = get(hObject,'String');
setappdata(handles.conn_port, 'port', port);


% --- Executes during object creation, after setting all properties.
function conn_port_CreateFcn(hObject, eventdata, handles)
% hObject    handle to conn_port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function conn_dbname_Callback(hObject, eventdata, handles)
% hObject    handle to conn_dbname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of conn_dbname as text
%        str2double(get(hObject,'String')) returns contents of conn_dbname as a double
dbname = get(hObject,'String');
setappdata(handles.conn_dbname, 'dbname', dbname);



% --- Executes during object creation, after setting all properties.
function conn_dbname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to conn_dbname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function conn_user_Callback(hObject, eventdata, handles)
% hObject    handle to conn_user (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of conn_user as text
%        str2double(get(hObject,'String')) returns contents of conn_user as a double
user = get(hObject,'String');
setappdata(handles.conn_user, 'user', user);

% --- Executes during object creation, after setting all properties.
function conn_user_CreateFcn(hObject, eventdata, handles)
% hObject    handle to conn_user (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function conn_pass_Callback(hObject, eventdata, handles)
% hObject    handle to conn_pass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of conn_pass as text
%        str2double(get(hObject,'String')) returns contents of conn_pass as a double
pass = get(hObject,'String');
setappdata(handles.conn_pass, 'pass', pass);


% --- Executes during object creation, after setting all properties.
function conn_pass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to conn_pass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in conn_connBT.
function conn_connBT_Callback(hObject, eventdata, handles)
% hObject    handle to conn_connBT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
adresa = getappdata(handles.conn_address , 'adresa');
port = getappdata(handles.conn_port , 'port');
dbname = getappdata(handles.conn_dbname , 'dbname');
user = getappdata(handles.conn_user , 'user');
pass = getappdata(handles.conn_pass , 'pass');
DBtyp = getappdata(handles.menu_DBtype , 'DBtyp');

if isempty(adresa) && isempty(port) && isempty(user) && isempty(pass)
    msgbox(sprintf('Some required fields are empty.'),'Error','error');
elseif isempty(dbname) == 1
    con_exists = evalin('base', 'exist(''con'',''var'') == 1');
    if con_exists == 1
            con = evalin('base', 'con');
            con.close();
            evalin('base', 'clear con');
    end
    
%     try
        switch DBtyp
            case {'MyS8'}
                sqladd = strcat(adresa,':',port);
                mysql8con(sqladd,user,pass);
                sqlexecute('SHOW DATABASES');
            case {'MyS57'}
                sqladd = strcat(adresa,':',port);
                mysql57con(sqladd,user,pass);
                sqlexecute('SHOW DATABASES');
            case {'Post'}
                sqladd = strcat(adresa,':',port);
                postgresqlcon(sqladd,user,pass);
                sqlexecute('SHOW DATABASES');
            case {'MSSQL'}
                sqladd = strcat(adresa,':',port);
                MSSQLconALT(sqladd,user,pass);
                sqlexecute('SELECT name FROM master.dbo.sysdatabases')
        end
    
        datastruct = evalin('base', 'datastruct');
        datac = struct2cell(datastruct);
        uiwait(msgbox('No database selected. A list of available databases will be displayed.','No DB','modal'));
        msgbox(datac{1},'List');
        con = evalin('base', 'con');
        con.close();
        evalin('base', 'clear con');
        
%     catch ME
%     msgbox(sprintf('Error connecting.'),'Error','error');
%     end    
else
    
con_exists = evalin('base', 'exist(''con'',''var'') == 1');
if con_exists == 1
    con = evalin('base', 'con');
    con.close();
end

% try
switch DBtyp
    case {'MyS8'}
        sqladd = strcat(adresa,':',port,'/',dbname);
        mysql8con(sqladd,user,pass);
    case {'MyS57'}
        sqladd = strcat(adresa,':',port,'/',dbname);
        mysql57con(sqladd,user,pass);
    case {'Post'}
        sqladd = strcat(adresa,':',port,'/',dbname);
        postgresqlcon(sqladd,user,pass);
    case {'MSSQL'}
        MSSQLcon(adresa,dbname,user,pass);
end

con_exists = evalin('base', 'exist(''con'',''var'') == 1');

assignin('base','DBtyp',DBtyp);
if con_exists == 1
    msgbox(sprintf('Connected'),'Connected','help');
end
% catch ME
%     msgbox(sprintf('Error connecting'),'Error','error');
% end
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();
