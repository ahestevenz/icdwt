function [cxd,sxd] = wcmp(n,thr,c,s,type_threshold,type_universal_threshold,type_universal_s_h)
%% WCMP
% Funcion que realiza la compresion de una imagen a partir de su DWT.

switch type_threshold
    case 1
        % --- Soft Thresholding ----
        cxd=c; sxd=s;
        for i=1:length(cxd);
            if abs(cxd(i))<thr
                cxd(i)=0;
            else
                cxd(i)=sign(cxd(i))*(abs(cxd(i)-thr));
            end
        end
    case 2
        % --- Hard Thresholding ----
        cxd=c; sxd=s;
        for i=1:length(cxd);
            if abs(cxd(i))<thr
                cxd(i)=0;
            end
        end
  
    case 3
        % --- Universal Thresholding ----

        switch type_universal_threshold
            case 1
                thr_gbl_type='rem_n0';
            case 2
                thr_gbl_type='bal_sn';
            case 3
                thr_gbl_type='sqrtbal_sn';
        end
        
        switch type_universal_s_h
            case 1
                thr_s_h='h';
            case 2
                thr_s_h='s';
        end
        
        keepapp=0;
        thr_val = wthrmngr('dw2dcompGBL',thr_gbl_type,c,s);
        [xd,cxd,sxd] = wdencmp('gbl',c,s,'haar',n,thr_val,thr_s_h,keepapp);
end
end

