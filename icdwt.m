function varargout = icdwt(varargin)
% ICDWT M-file for icdwt.fig
%      ICDWT, by itself, creates a new ICDWT or raises the existing
%      singleton*.
%
%      H = ICDWT returns the handle to a new ICDWT or the handle to
%      the existing singleton*.
%
%      ICDWT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ICDWT.M with the given input arguments.
%
%      ICDWT('Property','Value',...) creates a new ICDWT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before icdwt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to icdwt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help icdwt

% Last Modified by GUIDE v2.5 15-Jul-2014 11:35:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @icdwt_OpeningFcn, ...
                   'gui_OutputFcn',  @icdwt_OutputFcn, ...
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


% --- Executes just before icdwt is made visible.
function icdwt_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to icdwt (see VARARGIN)

% Choose default command line output for icdwt
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes icdwt wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Paths
addpath('./functions');


% --- Outputs from this function are returned to the command line.
function varargout = icdwt_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in browse_image.
function browse_image_Callback(hObject, ~, handles)
% hObject    handle to browse_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
[filename,pathname]=uigetfile({'*.bmp;*.tif','All Image Files'},'Seleccione un arhivo de imagen');
if ~filename
    errordlg('Seleccione un arhivo de imagen.');
    return;
end
image=imread(strcat(pathname,filename));
image_size=size(image);
if image_size(1)~=image_size(2)
    if image_size(1)<image_size(2)
        if mod(image_size(1),2)==0
            image=imresize(image,[image_size(1) image_size(1)]);
        else
            image=imresize(image,[image_size(1)-1 image_size(1)-1]);
        end
    else
        if mod(image_size(2),2)==0
            image=imresize(image,[image_size(2) image_size(2)]);
        else
            image=imresize(image,[image_size(2)-1 image_size(2)-1]);
        end
    end       
end
handles.sizeimg=size(image);
sizetmp=size(handles.sizeimg);
if sizetmp(2)>2
    image=rgb2gray(image);
end
handles.img=image;
handles.imginfo=whos('image');
guidata(hObject, handles);
axes(handles.image_in);
axis image;
colormap gray;
imagesc(handles.img);
set(handles.original_image,'String','Original');


% --- Executes on button press in DWT_Haar.
function DWT_Haar_Callback(hObject, ~, handles)
% hObject    handle to DWT_Haar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'img')
    img=handles.img;
else
    errordlg('Por favor seleccione primero una imagen.');
    return;
end

n=get(handles.level_decomposition,'Value');
[V,c,s] = imgdwt(n,img);
handles.c=c;
handles.s=s;
handles.n=n;
guidata(hObject,handles);
axes(handles.image_out);
axis image;
colormap gray;
imagesc(V);
set(handles.compressed_image,'String','[LL,HL;LH,HH]');


% --- Executes on button press in compress.
function compress_Callback(~, ~, handles)
% hObject    handle to compress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tipo_threshold = get(handles.threshold_type,'Value');
tipo_universal_threshold = get(handles.thr_universal_type,'Value');
tipo_universal_s_h = get(handles.hard_soft_type,'Value');

if tipo_threshold ~=3
if isfield(handles,'threshold')
    thr=handles.threshold;
else
    errordlg('Coloque el nivel del Threshold para la compresion');
    return;
end
else
    thr=0;
end

if isfield(handles,'c')
    ct=handles.c;
    st=handles.s;
    n=handles.n;
else
    errordlg('Debe calcular primero la DWT');
    return;
end

[cxd,sxd] = wcmp(n,thr,ct,st,tipo_threshold,tipo_universal_threshold,tipo_universal_s_h);
imgrec = uint8(waverec2(cxd,sxd,'haar'));
handles.imgrec=imgrec;
[ CR, MSE, PSNR ] = qcompparam(handles.img, handles.imgrec,nnz(handles.c), nnz(cxd));
set(handles.CR,'String',CR);
set(handles.MSE,'String',MSE);
set(handles.PSNR,'String',PSNR);
axes(handles.image_out);
axis image;
imagesc(handles.imgrec);
set(handles.compressed_image,'String','Compresion por DWT');



% --- Executes on button press in close.
function close_Callback(~, ~, ~)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
clc;
clear all;


function about_Callback(~,~,~)
    msgbox({'Compresion de Imagenes mediante Wavelets' '' ...
        'Trabajo Practico para la materia Analisis de Senales mediante Onditas' ...
        'Autor: Ariel Hernandez'...
        'Profesor: Dr. Carlos D`Attellis'...
        '2014'},'Acerca de');
    

function edit_level_threshold_Callback(hObject, ~, handles)
% hObject    handle to edit_level_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_level_threshold as text
%        str2double(get(hObject,'String')) returns contents of edit_level_threshold as a double

handles.threshold = str2double(get(hObject,'string')); 
if isnan(handles.threshold) 
     errordlg('Introduzca un valor numerico');
     set(handles.compression_type,'String','');
     set(handles.edit_level_threshold,'string','0');
     return;
end

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_level_threshold_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_level_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in level_decomposition.
function level_decomposition_Callback(hObject, eventdata, handles)
% hObject    handle to level_decomposition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: contents = cellstr(get(hObject,'String')) returns level_decomposition contents as cell array
%        contents{get(hObject,'Value')} returns selected item from level_decomposition


% --- Executes during object creation, after setting all properties.
function level_decomposition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to level_decomposition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in threshold_type.
function threshold_type_Callback(hObject, eventdata, handles)
% hObject    handle to threshold_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.threshold_type,'Value')==3
    set(handles.edit_level_threshold,'Enable','off');
    set(handles.thr_universal_type,'Enable','on');
    set(handles.hard_soft_type,'Enable','on');
else 
    set(handles.edit_level_threshold,'Enable','on');
    set(handles.thr_universal_type,'Enable','off');
    set(handles.hard_soft_type,'Enable','off');
    set(handles.thr_universal_type_description,'String','');
        set(handles.description_panel,'Title','');
    warndlg('Coloque el nivel del Threshold para la compresion');
    return;
end

% Hints: contents = cellstr(get(hObject,'String')) returns threshold_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from threshold_type


% --- Executes during object creation, after setting all properties.
function threshold_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshold_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in thr_universal_type.
function thr_universal_type_Callback(hObject, eventdata, handles)
% hObject    handle to thr_universal_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
type = get(handles.thr_universal_type,'Value');
switch type
    case 1
        set(handles.thr_universal_type_description,'String',... 
            'This option returns a threshold close to 0. A typical threshold value is median(abs(coefficients)).');
        set(handles.description_panel,'Title','Mediana');
    case 2
        set(handles.thr_universal_type_description,'String',... 
            'This option returns a threshold such that the percentages of retained energy and number of zeros are the same.');
        set(handles.description_panel,'Title','Energia');
    case 3
        set(handles.thr_universal_type_description,'String',... 
            'This option returns a threshold equal to the square root of the value such that the percentages of retained energy and number of zeros are the same.');
        set(handles.description_panel,'Title','Square root');
end
% Hints: contents = cellstr(get(hObject,'String')) returns thr_universal_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from thr_universal_type


% --- Executes during object creation, after setting all properties.
function thr_universal_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thr_universal_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DCT.
function DCT_Callback(hObject, eventdata, handles)
% hObject    handle to DCT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'img')
    img=handles.img;
else
    errordlg('Por favor seleccione una imagen primero.');
    return;
end
qty=get(handles.dct_quality_level,'Value');
[PSNR,MSE,CR, dct_img]=ccmp(img,qty);
set(handles.CR,'String',CR);
set(handles.MSE,'String',MSE);
set(handles.PSNR,'String',PSNR);
handles.imgrec_dct=dct_img;
guidata(hObject, handles);
axes(handles.image_out_jpeg);
axis image;
colormap gray;
imagesc(handles.imgrec_dct);
set(handles.compressed_jpeg,'String','Compresion por DCT');


% --- Executes on selection change in dct_quality_level.
function dct_quality_level_Callback(hObject, eventdata, handles)
% hObject    handle to dct_quality_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dct_quality_level contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dct_quality_level


% --- Executes during object creation, after setting all properties.
function dct_quality_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dct_quality_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in JPG.
function JPG_Callback(hObject, eventdata, handles)
% hObject    handle to JPG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isfield(handles,'img')
    img=handles.img;
else
    errordlg('Por favor seleccione una imagen primero.');
    return;
end

qty=get(handles.jpeg_quality_level,'Value');
[bytes_on_disk_jpg, jpg_img] = jcmp(img,qty);
bytes_on_disk_raw = handles.imginfo.bytes;
handles.imgrec_jpg=jpg_img;
guidata(hObject, handles);
[ CR, MSE, PSNR ] = qcompparam(handles.img, handles.imgrec_jpg, bytes_on_disk_raw, bytes_on_disk_jpg);
set(handles.CR,'String',CR);
set(handles.MSE,'String',MSE);
set(handles.PSNR,'String',PSNR);
axes(handles.image_out_jpeg);
axis image;
colormap gray;
imagesc(handles.imgrec_jpg);
set(handles.compressed_jpeg,'String','Compresion por JPEG');


% --- Executes on selection change in jpeg_quality_level.
function jpeg_quality_level_Callback(hObject, eventdata, handles)
% hObject    handle to jpeg_quality_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns jpeg_quality_level contents as cell array
%        contents{get(hObject,'Value')} returns selected item from jpeg_quality_level


% --- Executes during object creation, after setting all properties.
function jpeg_quality_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jpeg_quality_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in hard_soft_type.
function hard_soft_type_Callback(hObject, eventdata, handles)
% hObject    handle to hard_soft_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns hard_soft_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from hard_soft_type


% --- Executes during object creation, after setting all properties.
function hard_soft_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hard_soft_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
