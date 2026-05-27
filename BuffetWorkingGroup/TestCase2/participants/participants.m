clc; clear all; close all;

figure
hold on
axis equal
axis off
set(gcf,'position',[20 104 800 420])
set(gca,'position',[0 0.2 1 0.7])

hp = pie([8 7 6],{sprintf('Industry\n%i',8) sprintf('Academia\n%i',7) sprintf('Government\n%i',6)});

hp(1).FaceColor = [32 20 89]/255;
hp(2).Color = [32 20 89]/255;
hp(2).HorizontalAlignment = 'Center';
hp(2).FontWeight = 'bold';
hp(2).Position = [-1.35 0.60];

hp(3).FaceColor = [55 108 137]/255;
hp(4).Color = [55 108 137]/255;
hp(4).HorizontalAlignment = 'Center';
hp(4).FontWeight = 'bold';
hp(4).Position = [0 -1.05];

hp(5).FaceColor = [116 183 124]/255;
hp(6).Color = [116 183 124]/255;
hp(6).HorizontalAlignment = 'Center';
hp(6).FontWeight = 'bold';
hp(6).Position = [1.45 0.35];

exportgraphics(gcf,'participants.pdf','ContentType','vector')
