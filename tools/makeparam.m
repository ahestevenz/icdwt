%% Script para el Analisis de Resultados

% Imagen
addpath('./tools');
addpath('../img');
folder='img';
image='lena.bmp';
file=fullfile(folder,image);
img=imread(file);
sizetmp=size(size(img));
if sizetmp(2)>2
    img=rgb2gray(img);
end
imginfo=whos('img');

% Compresion con DWT
param=[];
aux=[];
w='haar';

for n=1:8;%Nivel de descomposicion
    [V,c,s] = imgdwt(n,img);
    for i=1:2;
        for thr=1:10:200;
                [cxd,sxd] = wcmp(n,thr,c,s,i,1,1);
                imgrec = uint8(waverec2(cxd,sxd,w));
                [CR, MSE, PSNR] = qcompparam(img, imgrec, nnz(c), nnz(cxd));
                aux=[0,n,i,0,0,thr,0,CR, MSE, PSNR];
                param=cat(1,param,aux);
        end
    end
        
    for j=1:3;
        for k=1:2;
            [cxd,sxd] = wcmp(n,0,c,s,3,j,k);
            imgrec = uint8(waverec2(cxd,sxd,w));
            [CR, MSE, PSNR] = qcompparam(img, imgrec, nnz(c), nnz(cxd));
            aux=[0,n,3,j,k,0,0,CR, MSE, PSNR];
            param=cat(1,param,aux);
        end
    end
end

% Compresion con DCT/JPEG
for l=1:10;
        [PSNR,MSE,CR, dct_img]=ccmp(img,l);
        aux=[1,0,0,0,0,0,l*10,CR, MSE, PSNR];
        param=cat(1,param,aux);
        [bytes_on_disk_jpg, jpg_img] = jcmp(img, l);
        [CR, MSE, PSNR] = qcompparam(img, jpg_img, imginfo.bytes, bytes_on_disk_jpg);
        aux=[2,0,0,0,0,0,l*10,CR, MSE, PSNR];
        param=cat(1,param,aux);
end
fparam = cat(2,image,'_parameters.mat');
save(fparam,'param');
