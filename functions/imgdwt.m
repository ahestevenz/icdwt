function [V,c,s] = imgdwt(n,img)
%% IMGDWT
% Calcula la DWT de una imagen.

w='haar';
[c,s] = wavedec2(img,n,w);
V=[];
for i=n:-1:1;
    LL = appcoef2(c,s,w,i);
    [HL,LH,HH] = detcoef2('all',c,s,i);
    if i==n
        V=[LL,HL;LH,HH];
    end
    if i~=n
        V=cat(1,cat(2,V,HL),cat(2,LH,HH));
    end
end

end

