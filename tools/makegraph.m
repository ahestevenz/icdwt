%% Script grafica los parametros obtenidos en makeparam.m

% parameters.mat
image='lena.bmp';
fparam = cat(2,image,'_parameters.mat');
load(fparam);

% Colors
blue=[0.0431372560560703 0.0823529437184334 0.505882382392883];
green=[0.0588235296308994 0.474509805440903 0.0313725508749485];
orange=[0.847058832645416 0.160784319043159 0];
lred=[0.584313750267029 0.196078434586525 0.196078434586525];
mustard=[0.600000023841858 0.600000023841858 0];
purple=[0.521568655967712 0.466666668653488 0.749019622802734];
magenta=[0.749019622802734 0 0.749019622802734];
black=[0 0 0];

% DWT: THR vs CR vs n (Hard y Soft)
figure0 = figure('Name','Compression Ratio');
          axes2 = axes('Parent',figure0,'YGrid','on','XGrid','on','FontWeight','bold','FontSize',13);
          box(axes2,'on');
          hold(axes2,'all');
          plot(param(1:20,6),param(1:20,8),'LineWidth',1.5,'Color',blue);
          plot(param(47:66,6),param(47:66,8),'LineWidth',1.5,'Color',green);
          plot(param(94:112,6),param(94:112,8),'LineWidth',1.5,'Color',orange);
          plot(param(139:158,6),param(139:158,8),'LineWidth',1.5,'Color',lred);
          plot(param(185:204,6),param(185:204,8),'LineWidth',1.5,'Color',mustard);
          plot(param(231:250,6),param(231:250,8),'LineWidth',1.5,'Color',magenta);
          plot(param(277:296,6),param(277:296,8),'LineWidth',1.5,'Color',black);
          plot(param(323:342,6),param(323:342,8),'LineWidth',1.5,'Color',purple);
          hleg0 = legend('n=1','n=2','n=3','n=4','n=5','n=6','n=7','n=8','Location','northwest');
          xlabel('Threshold','FontWeight','bold','FontSize',13)
          ylabel('CR','FontWeight','bold','FontSize',13)
          title(cat(2,'Compression Ratio Soft Thresholding: ',image),'FontWeight','bold','FontSize',13)
          
figure2 = figure('Name','Compression Ratio');
          axes2 = axes('Parent',figure2,'YGrid','on','XGrid','on','FontWeight','bold','FontSize',13);
          box(axes2,'on');
          hold(axes2,'all');
          plot(param(21:40,6),param(21:40,8),'LineWidth',1.5,'Color',blue);
          plot(param(67:86,6),param(67:86,8),'LineWidth',1.5,'Color',green);
          plot(param(113:132,6),param(113:132,8),'LineWidth',1.5,'Color',orange);
          plot(param(159:178,6),param(159:178,8),'LineWidth',1.5,'Color',lred);
          plot(param(205:224,6),param(205:224,8),'LineWidth',1.5,'Color',mustard);
          plot(param(251:270,6),param(251:270,8),'LineWidth',1.5,'Color',magenta);
          plot(param(297:316,6),param(297:316,8),'LineWidth',1.5,'Color',black);
          plot(param(343:362,6),param(343:362,8),'LineWidth',1.5,'Color',purple);
          hleg2 = legend('n=1','n=2','n=3','n=4','n=5','n=6','n=7','n=8','Location','northwest');
          xlabel('Threshold','FontWeight','bold','FontSize',13)
          ylabel('CR','FontWeight','bold','FontSize',13)
          title(cat(2,'Compression Ratio Hard Thresholding: ',image),'FontWeight','bold','FontSize',13)
          
% DWT: THR vs PSNR vs n (Hard y Soft)
figure1 = figure('Name','Peak Signal to Noise Ratio (PSNR)');
          axes2 = axes('Parent',figure1,'YGrid','on','XGrid','on','FontWeight','bold','FontSize',13);
          box(axes2,'on');
          hold(axes2,'all');
          plot(param(1:20,6),param(1:20,10),'LineWidth',1.5,'Color',blue);
          plot(param(47:66,6),param(47:66,10),'LineWidth',1.5,'Color',green);
          plot(param(94:112,6),param(94:112,10),'LineWidth',1.5,'Color',orange);
          plot(param(139:158,6),param(139:158,10),'LineWidth',1.5,'Color',lred);
          plot(param(185:204,6),param(185:204,10),'LineWidth',1.5,'Color',mustard);
          plot(param(231:250,6),param(231:250,10),'LineWidth',1.5,'Color',magenta);
          plot(param(277:296,6),param(277:296,10),'LineWidth',1.5,'Color',black);
          plot(param(323:342,6),param(323:342,10),'LineWidth',1.5,'Color',purple);
          hleg1 = legend('n=1','n=2','n=3','n=4','n=5','n=6','n=7','n=8','Location','northeast');
          xlabel('Threshold','FontWeight','bold','FontSize',13)
          ylabel('PSNR (dB)','FontWeight','bold','FontSize',13)
          title(cat(2,'PSNR Soft Thresholding: ',image),'FontWeight','bold','FontSize',13)
          
figure3 = figure('Name','Peak Signal to Noise Ratio (PSNR)');
          axes2 = axes('Parent',figure3,'YGrid','on','XGrid','on','FontWeight','bold','FontSize',13);
          box(axes2,'on');
          hold(axes2,'all');
          plot(param(21:40,6),param(21:40,10),'LineWidth',1.5,'Color',blue);
          plot(param(67:86,6),param(67:86,10),'LineWidth',1.5,'Color',green);
          plot(param(113:132,6),param(113:132,10),'LineWidth',1.5,'Color',orange);
          plot(param(159:178,6),param(159:178,10),'LineWidth',1.5,'Color',lred);
          plot(param(205:224,6),param(205:224,10),'LineWidth',1.5,'Color',mustard);
          plot(param(251:270,6),param(251:270,10),'LineWidth',1.5,'Color',magenta);
          plot(param(297:316,6),param(297:316,10),'LineWidth',1.5,'Color',black);
          plot(param(343:362,6),param(343:362,10),'LineWidth',1.5,'Color',purple);
          hleg3 = legend('n=1','n=2','n=3','n=4','n=5','n=6','n=7','n=8','Location','northeast');
          xlabel('Threshold','FontWeight','bold','FontSize',13)
          ylabel('PSNR (dB)','FontWeight','bold','FontSize',13)
          title(cat(2,'PSNR Hard Thresholding: ',image),'FontWeight','bold','FontSize',13)

% DWT: n vs CR vs UTHR
figure4 = figure('Name','Compression Ratio');
          subplot(1,2,1,'Parent',figure4,'YGrid','on','XGrid','on','FontWeight','bold','FontSize',13);hold;
          plot(param([41,87,133,179,225,271,317,363],8),'LineWidth',1.5,'Color',blue);
          plot(param([43,89,135,181,227,273,319,365],8),'LineWidth',1.5,'Color',green);
          plot(param([45,91,137,183,229,275,321,367],8),'LineWidth',1.5,'Color',lred);
          title(cat(2,'Universal Thresholding (Hard): ',image),'FontWeight','bold','FontSize',13)
          xlabel('n (nivel de descomposicion)','FontWeight','bold','FontSize',13)
          ylabel('CR','FontWeight','bold','FontSize',13)
          hleg4 = legend('Mediana','Retained Energy','Square Root Retained Energy');
          set(hleg4,'Position',[0.228549859991526 0.620240695853408 0.199678718850012 0.0886138292884859]);
          subplot(1,2,2,'Parent',figure4,'YGrid','on','XGrid','on','FontWeight','bold','FontSize',13);hold;
          plot(param([41,87,133,179,225,271,317,363]+1,8),'LineWidth',1.5,'Color',blue);
          plot(param([43,89,135,181,227,273,319,365]+1,8),'LineWidth',1.5,'Color',green);
          plot(param([45,91,137,183,229,275,321,367]+1,8),'LineWidth',1.5,'Color',lred);
          title(cat(2,'Universal Thresholding (Soft): ',image),'FontWeight','bold','FontSize',13)
          hleg5 = legend('Mediana','Retained Energy','Square Root Retained Energy');
          set(hleg5,'Position',[0.688269649833908 0.602835632562269 0.199678718850012 0.0886138292884859]);
          xlabel('n (nivel de descomposicion)','FontWeight','bold','FontSize',13)
          ylabel('CR','FontWeight','bold','FontSize',13)

% DWT: n vs PSNR vs UTHR
figure5 = figure('Name','Peak Signal to Noise Ratio (PSNR)');
          subplot(1,2,1,'Parent',figure5,'YGrid','on','XGrid','on','FontWeight','bold','FontSize',13);hold;
          plot(param([41,87,133,179,225,271,317,363],10),'LineWidth',1.5,'Color',blue);
          plot(param([43,89,135,181,227,273,319,365],10),'LineWidth',1.5,'Color',green);
          plot(param([45,91,137,183,229,275,321,367],10),'LineWidth',1.5,'Color',lred);
          title(cat(2,'Universal Thresholding (Hard): ',image),'FontWeight','bold','FontSize',13)
          xlabel('n (nivel de descomposicion)','FontWeight','bold','FontSize',13)
          ylabel('PSNR (dB)','FontWeight','bold','FontSize',13)
          hleg6 = legend('Mediana','Retained Energy','Square Root Retained Energy');
          set(hleg6,'Position', [0.151013333807399 0.648226085934975 0.199678718850012 0.132911392405063]);
          subplot(1,2,2,'Parent',figure5,'YGrid','on','XGrid','on','FontWeight','bold','FontSize',13);hold;
          plot(param([41,87,133,179,225,271,317,363]+1,10),'LineWidth',1.5,'Color',blue);
          plot(param([43,89,135,181,227,273,319,365]+1,10),'LineWidth',1.5,'Color',green);
          plot(param([45,91,137,183,229,275,321,367]+1,10),'LineWidth',1.5,'Color',lred);
          title(cat(2,'Universal Thresholding (Soft): ',image),'FontWeight','bold','FontSize',13);
          hleg7 = legend('Mediana','Retained Energy','Square Root Retained Energy');
          set(hleg7,'Position',[0.584857566214904 0.658107123738464 0.199678718850012 0.0886138292884859]);
          xlabel('n (nivel de descomposicion)','FontWeight','bold','FontSize',13)
          ylabel('PSNR (dB)','FontWeight','bold','FontSize',13)
          
% DWT/DCT/JPEG: CR vs PSNR
figure6 = figure('Name','Peak Signal to Noise Ratio (PSNR)');
          axes2 = axes('Parent',figure6,'YGrid','on','XGrid','on','FontWeight','bold','FontSize',13);
          box(axes2,'on');
          hold(axes2,'all');
          %JPEG
          plot(param([369,371,373,375,377,379,381,383,385]+1,8),param([369,371,373,375,377,379,381,383,385]+1,10),...
              'LineWidth',1.2,'Marker','^','LineStyle','--','Color',lred);
          %DCT
          plot(param([369,371,373,375,377,379,381,383,385],8),param([369,371,373,375,377,379,381,383,385],10),...
              'LineWidth',1.2,'Marker','square','LineStyle','--','Color',purple);
          %DWT
          plot(param(1:20,8),param(1:20,10),'LineWidth',1.2,'Color',blue); %n=1 soft
          plot(param(47:66,8),param(47:66,10),'LineWidth',1.2,'Color',green); %n=2 soft
          plot(param(21:40,8),param(21:40,10),'LineWidth',1.2,'Color',mustard);%n=1 hard
          plot(param(67:86,8),param(67:86,10),'LineWidth',1.2,'Color',magenta);%n=2 hard
          
          hleg8 = legend('JPEG','DCT','DWT n=1 soft','DWT n=2 soft','DWT n=1 hard','DWT n=2 hard','Location','northeast');
          xlabel('CR','FontWeight','bold','FontSize',13)
          ylabel('PSNR (dB)','FontWeight','bold','FontSize',13)
          title(cat(2,'Peak Signal to Noise Ratio JPEG/DCT/DWT: ',image),'FontWeight','bold','FontSize',13)
