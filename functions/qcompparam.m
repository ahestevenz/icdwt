function [ CR, MSE, PSNR ] = qcompparam(img, imgrec, img_size, imgrec_size)
%% qcompparam 
%   Funcion que obtiene los siguientes parametros de calidad luego de
%   aplicar cualquier tecnica de compresion de imagenes.
%   

sizeimg=size(img);
CR = img_size/imgrec_size;
MSE = sum(sum((img-imgrec).^2))/(sizeimg(1)*sizeimg(2));
PSNR=20*log10(255/sqrt(MSE));

end

