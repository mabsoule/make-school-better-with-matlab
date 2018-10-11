% SYDE252, Fall 2018
% Convlution Example 2
% Ning Jiang
%%%%%%%%%%%%%%%%%%%

clear;
screenSize = get(0,'ScreenSize'); % get the screen size
figure; % create an empty figure
set(gcf,'position',[1,1,screenSize(3),screenSize(4)]); % position the figure the cover the right half of the screen

speed = nan;

%% example 2.4 Oppenheim P. 85-88

xlim = [-10,10];
alpha = 1.3;
yn = alpha.^(0:6);
xn = ones(1,5);
xshift = 2;



ax(5) = subplot(5,1,1);
h_stem5 = stem(xlim(1):xlim(2),[zeros(1,(-xlim(1)-xshift)),xn,zeros(1,xlim(2)-length(xn)+1+xshift)]);
set(ax(5),'ylim',[0,1.5]);
set(h_stem5,'MarkerFaceColor','blue','MarkerEdgeColor','blue'); % change the look of the signal (fill the circles)
set(gca,'fontsize',30,'xlim',xlim,'ytick',0.5:0.5:2.5,'xticklabel',{},'position',[0.13,0.86,0.775,0.1]); % set the x-range, xtick, and ytick
h_label5(1) = xlabel('n','Position',[11,0.75,0],'interpreter','latex'); % write xlabel
h_label5(2) = title('$x[n]$','fontsize',30); % write ylabel
set(h_label5(2),'interpreter','latex','Position',[-12,0.75,0]); % set the label and title to be LaTeX format
set(h_label5,'rotation',0); % rotation the ylabel
grid on; 


ax(4) = subplot(5,1,2);
h_stem4 = stem((xlim(1):xlim(2)),[zeros(1,abs(xlim(1))),yn,zeros(1,xlim(2)-length(yn)+1)]);
set(ax(4),'ylim',[0,alpha^6*1.2],'position',[0.13,0.72,0.775,0.1]); % move the yaxis and ylabe to the center
set(h_stem4,'color','blue','MarkerFaceColor','blue','MarkerEdgeColor','blue'); % change the look of the signal (fill the circles)
set(ax(4),'fontsize',30);
h_label4(1) = xlabel('n','interpreter','latex');
set(h_label4(1),'Position',[10.5,0,0]);
h_label4(2) = title('$y[n]$','fontsize',30);
set(h_label4(1),'Position',[11,2,0]);
set(h_label4(2),'Position',[-12,2,0]);
set(h_label4(2),'interpreter','latex','fontsize',30,'Position',[-12,2,0]);
grid on;

pause;

ax(1) = subplot(5,1,3); % subplot 1 x[n]
h_stem1 = stem(xlim(1):xlim(2),[zeros(1,(-xlim(1)-xshift)),xn,zeros(1,xlim(2)-length(xn)+1+xshift)]); % draw x[n]
set(ax(1),'YAxisLocation','origin'); % move the yaxis and ylabe to the center
set(gca,'ylim',[0,1.5]); % set the height of the axis to 1.5 unit
set(h_stem1,'color','red','MarkerFaceColor','red','MarkerEdgeColor','red'); % change the look of the signal (fill the circles)
set(gca,'xlim',xlim,'ytick',0.5:0.5:2.5,'xticklabel',{},'position',[0.13,0.5,0.775,0.1]); % set the x-range, xtick, and ytick
set(ax(1),'fontsize',30);
h_label1(1) = xlabel('k','Position',[11,0.25,0],'fontsize',30,'interpreter','latex');
h_patch1 = patch(-xshift+[0,(length(xn)-1)*ones(1,2),0],[0,0,2.5,2.5],'black');   % create a patch to indicat the non-zeros range of y[n-k]
set(h_patch1,'facealpha',0.3,'edgecolor','none');
h_label1(2) = title('$x[k]$','fontsize',30); % write ylabel
set(h_label1(2),'interpreter','latex','fontsize',30); % set the label and title to be LaTeX format
set(h_label1(2),'rotation',0,'Position',[-12,0.75,0]); % rotation the ylabel
grid on; 
pause;


ax(2)= subplot(5,1,4); % subplot 2 y[n]

h_stem2 = stem(xlim(1):xlim(2),[zeros(1,-xlim(1)),fliplr(yn),zeros(1,xlim(2)-length(yn)+1)]);
set(ax(2),'fontsize',30,'YAxisLocation','origin'); % move the yaxis and ylabe to the center
set(gca,'ylim',[0,alpha^6*1.2]); % set the height of the axis to 1.5 unit

set(h_stem2,'color','red','MarkerFaceColor','red','MarkerEdgeColor','red'); % change the look of the signal (fill the circles)
set(gca,'xlim',xlim,'ytick',1:floor(alpha^6),'position',[0.1300    0.3500    0.7750    0.1000]); % set the x-range, xtick, and ytick
h_patch2 = patch([-100,-80,-80,-100],[0,0,alpha^6*1.2*ones(1,2)],'black');   % create a patch to indicat the non-zeros range of h[n-k]
set(h_patch2,'facealpha',0.3,'edgecolor','none');
h_label2(1) = xlabel('k'); % write xlabel
set(h_label2(1),'Position',[11,1,0],'fontsize',30);
h_label2(2) = title('$y[n-k]$','Position',[-12,3,0]); % write ylabel
set(h_label2,'interpreter','latex','fontsize',30); % set the label and title to be LaTeX format
set(h_label2(2),'rotation',0); % rotation the ylabel
grid on;

% 
% set(h_label1(1),'string','k');
% set(h_label1(2),'string','$x[k]$');
% set(h_label2(1),'string','k');
% set(h_label2(2),'string','$y[n-k]$');


ax(3) = subplot(5,1,5);
h_stem3 = stem((xlim(1)+(0:length(yn)-2)),zeros(1,length(yn)-1));
set(ax(3),'ylim',[0,18],'xlim',xlim,'position',[0.13,0.05,0.775,0.18],'fontsize',30); % move the yaxis and ylabe to the center
set(h_stem3,'color','red','MarkerFaceColor','red','MarkerEdgeColor','red'); % change the look of the signal (fill the circles)
h_label3(1) = xlabel('n','fontsize',30,'Position',[11,2,0]);
h_label3(2) = title('$x[n]\ast y[n]={\displaystyle \sum_{k=-\infty}^{+\infty}x[k]y[n-k]}$');
h_label3(3) = ylabel('$x[n] \ast y[n]$');
set(h_label3(3),'rotation',0,'interpreter','latex','fontsize',30,'Position',[-12,5,0]);
set(h_label3,'interpreter','latex','fontsize',30);
set(h_label3(2),'Position',[0,12,0]);
grid on; 



dummy = xlim(1);
while (length(yn) + dummy - 1) <= xlim(2)
    nPreZeros = dummy-xlim(1);
    nPostZeros = (xlim(2)-xlim(1)+1)-length(yn)-nPreZeros;
    ynk = [zeros(1,nPreZeros),fliplr(yn),zeros(1,nPostZeros)];
    set(h_stem2,'ydata',ynk);
    currentN = dummy + length(yn)-1;
    set(h_patch2,'xdata',nPreZeros+xlim(1)+[0,length(yn)-1,length(yn)-1,0])    
    set(h_label2(2),'string',['$y[',num2str(currentN),'-k]$']);
    currentOutput = get(h_stem1,'ydata')*get(h_stem2,'ydata')';
    xhConv = get(h_stem3,'ydata');
    %     xhCov(dummy+length(yn)+abs(xlim(1))) = currentOutput;
    xhConv(end+1) = currentOutput;
    if isnan(speed)
        pause;
    else
        pause(speed);
    end
    set(h_label3(2),'string',['$x[',num2str(currentN),']\ast y[',num2str(currentN),...
        ']={\displaystyle \sum_{k=-\infty}^{+\infty}x[k]y[',num2str(currentN),'-k]}=',num2str(currentOutput),'$'])

    set(h_stem3,'xdata',xlim(1):currentN,'ydata',xhConv);
    %     pause(2);
    if isnan(speed)
        pause;
    else
        pause(speed);
    end
    dummy = dummy + 1;
end





