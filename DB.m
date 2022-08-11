% Rozhrani pro praci s databazemi
% Dependence: sqlfetch.m sqlexecute.m
% Petr Michalek

function varargout = DB(varargin)
% DB MATLAB code for DB.fig
%      DB, by itself, creates a new DB or raises the existing
%      singleton*.
%
%      H = DB returns the handle to a new DB or the handle to
%      the existing singleton*.
%
%      DB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DB.M with the given input arguments.
%
%      DB('Property','Value',...) creates a new DB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DB_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DB_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DB

% Last Modified by GUIDE v2.5 23-Jun-2020 16:05:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DB_OpeningFcn, ...
                   'gui_OutputFcn',  @DB_OutputFcn, ...
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


% --- Executes just before DB is made visible.
function DB_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DB (see VARARGIN)

% Choose default command line output for DB
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.DB_condition_between,'Visible','Off');
operator = '=';
setappdata(handles.DB_condition_operator, 'operator', operator);

% UIWAIT makes DB wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DB_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in connectBT.
function connectBT_Callback(hObject, eventdata, handles)
% hObject    handle to connectBT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in fetchBT.
function fetchBT_Callback(hObject, eventdata, handles)
% hObject    handle to fetchBT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Conn_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Conn_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Conn_menu_new_Callback(hObject, eventdata, handles)
% hObject    handle to Conn_menu_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(conn);



% --------------------------------------------------------------------
function Conn_menu_close_Callback(hObject, eventdata, handles)
% hObject    handle to Conn_menu_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
con_exists = evalin('base', 'exist(''con'',''var'') == 1');
if con_exists == 1
    con = evalin('base', 'con');
    con.close();
    evalin('base', 'clear con');
    msgbox(sprintf('Connection closed'),'Connection closed','help');
    set(handles.DB_text_table, 'String', '');
    set(handles.listbox1,'String','');
else
    msgbox(sprintf('No active connection detected.'),'No connection','error');
end



function DB_sqlCOMMAND_Callback(hObject, eventdata, handles)
% hObject    handle to DB_sqlCOMMAND (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DB_sqlCOMMAND as text
%        str2double(get(hObject,'String')) returns contents of DB_sqlCOMMAND as a double
sqlprikaz = get(hObject,'String');
setappdata(handles.DB_sqlCOMMAND, 'sqlprikaz', sqlprikaz);

% --- Executes during object creation, after setting all properties.
function DB_sqlCOMMAND_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DB_sqlCOMMAND (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DB_execute.
function DB_execute_Callback(hObject, eventdata, handles)
% hObject    handle to DB_execute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sqlprikaz = getappdata(handles.DB_sqlCOMMAND , 'sqlprikaz');

con_exists = evalin('base', 'exist(''con'',''var'') == 1');
if con_exists == 0
    msgbox(sprintf('No connection available.'),'Error', 'error');
else

sqlexecute(sqlprikaz);
sel = 'select';
sho = 'show';
if contains(lower(sqlprikaz), sel) == 1 || contains(lower(sqlprikaz), sho) == 1
    datatab = evalin('base', 'datatab');
    fig = uifigure('Name','SQL data','Position',[50 50 1280 720]);
    uni = get(fig,'Units');
    table = uitable(fig,'Data',datatab,'Position',[0 0 1280 720],'Units',uni);
else
    uprav = evalin('base','uprav');
    string = strcat('Statement executed. Rows affected: ',num2str(uprav));
	msgbox(string,'Statement executed.','help' );
end

end


% --- Executes on button press in DB_show_tables.
function DB_show_tables_Callback(hObject, eventdata, handles)
% hObject    handle to DB_show_tables (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

con_exists = evalin('base', 'exist(''con'',''var'') == 1');
if con_exists == 0
    msgbox(sprintf('No connection available.'),'Error', 'error');
else
DBtyp = evalin('base','DBtyp');
switch DBtyp
    case {'MSSQL'}
        sqlfetch('SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES;');
        relations = evalin('base','datastruct');
        set(handles.listbox1,'string',relations.TABLE_NAME);
    case {'MyS57','MyS8'}
        sqlfetch('SHOW TABLES;');
        relations = evalin('base','datastruct');
        set(handles.listbox1,'string',relations.TABLE_NAME);
    case {'Post'}
        sqlfetch("SELECT * FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog'AND schemaname != 'information_schema';");
        relations = evalin('base','datastruct');
        set(handles.listbox1,'string',relations.tablename);
end
setappdata(handles.DB_show_tables, 'relations', relations);
end




% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
con_exists = evalin('base', 'exist(''con'',''var'') == 1');
if con_exists == 0
    msgbox(sprintf('No connection available.'),'Error', 'error');
else 
tabindex = get(handles.listbox1,'value');
 setappdata(handles.DB_show_tables,'tabindex',tabindex);
 DBtyp = evalin('base','DBtyp');
 relations = getappdata(handles.DB_show_tables, 'relations');
 
switch DBtyp
    case {'MSSQL','MyS57','MyS8'}
        set(handles.DB_text_table, 'String', relations.TABLE_NAME(tabindex));
    case {'Post'}
        set(handles.DB_text_table, 'String', relations.tablename(tabindex));
end
end

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DB_tables_preview.
function DB_tables_preview_Callback(hObject, eventdata, handles)
% hObject    handle to DB_tables_preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
con_exists = evalin('base', 'exist(''con'',''var'') == 1');
if con_exists == 0
    msgbox(sprintf('No connection available.'),'Error', 'error');
else 
DBtyp = evalin('base','DBtyp');
relations = getappdata(handles.DB_show_tables, 'relations');
tabindex = getappdata(handles.DB_show_tables, 'tabindex');
if isempty(tabindex) == 1
    msgbox('No table selected.','No table','warn');
else
switch DBtyp
    case {'MSSQL','MyS57','MyS8'}
        table = relations.TABLE_NAME(tabindex);  
    case {'Post'}
        table = relations.tablename(tabindex);
end
sqlprikaz = strcat('SELECT * FROM ',table);
sqlfetch(sqlprikaz);
datatab = evalin('base', 'datatab');
fig = uifigure('Name','SQL data','Position',[50 50 1280 720]);
uni = get(fig,'Units');
table = uitable(fig,'Data',datatab,'Position',[0 0 1280 720],'Units',uni);
end
end


function DB_condition_value_Callback(hObject, eventdata, handles)
% hObject    handle to DB_condition_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DB_condition_value as text
%        str2double(get(hObject,'String')) returns contents of DB_condition_value as a double
value = get(hObject,'String');
setappdata(handles.DB_condition_value, 'value', value);


% --- Executes during object creation, after setting all properties.
function DB_condition_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DB_condition_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DB_condition_column_Callback(hObject, eventdata, handles)
% hObject    handle to DB_condition_column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DB_condition_column as text
%        str2double(get(hObject,'String')) returns contents of DB_condition_column as a double
column = get(hObject,'String');
setappdata(handles.DB_condition_column, 'column', column);



% --- Executes during object creation, after setting all properties.
function DB_condition_column_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DB_condition_column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DB_condition_showBT.
function DB_condition_showBT_Callback(hObject, eventdata, handles)
% hObject    handle to DB_condition_showBT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
con_exists = evalin('base', 'exist(''con'',''var'') == 1');
if con_exists == 0
    msgbox(sprintf('No connection available.'),'Error', 'error');
else 
DBtyp = evalin('base','DBtyp');
relations = getappdata(handles.DB_show_tables, 'relations');
tabindex = getappdata(handles.DB_show_tables, 'tabindex');
column = getappdata(handles.DB_condition_column, 'column');
operator = getappdata(handles.DB_condition_operator, 'operator');
value = getappdata(handles.DB_condition_value, 'value');
bet = 'between';
if isempty(tabindex) ==1
    msgbox('No table selected.','No table','warn');
else
if contains(lower(operator), bet) == 1
    between = getappdata(handles.DB_condition_between, 'between');
    if isempty(between)==1
        msgbox(sprintf('Condition not set.'),'Error', 'warn');
    else
        value = strcat(value,{' '},'AND',{' '},between);
    end
    
elseif isempty(value) == 0
    value = strcat("'",value,"'");
end

if isempty(value)==1 || isempty(column)==1
    msgbox(sprintf('Condition not set.'),'Error', 'warn');

else
    
switch DBtyp
    case {'MSSQL','MyS57','MyS8'}
        table = relations.TABLE_NAME(tabindex);  
    case {'Post'}
        table = relations.tablename(tabindex);
end
sqlprikaz = strcat('SELECT * FROM',{' '},table,{' '},'WHERE',{' '},column,{' '},operator,{' '},value,';');
set(handles.DB_sqlCOMMAND, 'String', sqlprikaz);
setappdata(handles.DB_sqlCOMMAND, 'sqlprikaz', sqlprikaz);
end
end
end



% --- Executes on selection change in DB_condition_operator.
function DB_condition_operator_Callback(hObject, eventdata, handles)
% hObject    handle to DB_condition_operator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DB_condition_operator contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DB_condition_operator
volba = cellstr(get(hObject,'String'));
operator = volba{get(hObject,'Value')};
setappdata(handles.DB_condition_operator,'operator',operator);

bet = 'between';
if contains(lower(operator), bet) == 1
    set(handles.DB_condition_between,'Visible','On');
else
    set(handles.DB_condition_between,'Visible','Off');
end



% --- Executes during object creation, after setting all properties.
function DB_condition_operator_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DB_condition_operator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function DB_condition_between_Callback(hObject, eventdata, handles)
% hObject    handle to DB_condition_between (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DB_condition_between as text
%        str2double(get(hObject,'String')) returns contents of DB_condition_between as a double
between = get(hObject,'String');
setappdata(handles.DB_condition_between, 'between', between);


% --- Executes during object creation, after setting all properties.
function DB_condition_between_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DB_condition_between (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DB_condition_executeBT.
function DB_condition_executeBT_Callback(hObject, eventdata, handles)
% hObject    handle to DB_condition_executeBT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sqlfetch(sqlprikaz);
datatab = evalin('base', 'datatab');
fig = uifigure('Name','SQL data','Position',[50 50 1280 720]);
uni = get(fig,'Units');
table = uitable(fig,'Data',datatab,'Position',[0 0 1280 720],'Units',uni);
