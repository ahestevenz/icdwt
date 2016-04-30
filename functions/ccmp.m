function [PSNR,MSE,CR, dct_img]=ccmp(img,quality)
%% cdencmp
%      Funcion que realiza la compresion de una imagen a partir de la
%      transformada discreta coseno.
%      
% Uso:
%      [PSNR,MSE,CR, dct_img]=cdencmp(img,quality)
%
% Parametros:
%   img: imagen
%   quality: calidad de la imagen comprimida cuantizada de 10 a 100
%
% Retorno:
%   MSE: error cuadratico medio
%   PSNR: relacion senial a ruido pico
%   CR: compression ratio
%   dct_img: imagen comprimida
%

n=8;
image = im2double(img);
T = dctmtx(n);
dct = @(block_struct) T*block_struct.data*T';
B = blockproc(image,[n n],dct);

mask=zeros(n);
ones=floor(sqrt(10*quality*64/100));

if ones<=n
    mask(1:ones,1:ones)=1;
else
    mask(1:n,1:n)=1;
end
    
B2 = blockproc(B,[n n],@(block_struct) mask .* block_struct.data);
invdct = @(block_struct) T' * block_struct.data * T;
dct_img = blockproc(B2,[n n],invdct);
dct_img_uint=uint8(255*dct_img);
[ CR, MSE, PSNR ] = qcompparam(img, dct_img_uint, nnz(B), nnz(B2));
end