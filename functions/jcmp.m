function [bytes_on_disk_jpg, jpg_img] = jcmp(img, quality )
%% JCMP
% Funcion que realiza la compresi?n de una imagen en JPEG.

imwrite(img,'tmp.jpg','quality',quality*10);
jpg_img=imread('tmp.jpg');
jpg_info = imfinfo('tmp.jpg');
bytes_on_disk_jpg = jpg_info.FileSize;
delete('tmp.jpg');
end

