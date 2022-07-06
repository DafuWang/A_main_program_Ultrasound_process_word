function [II,I,save_adress_name]=figure_plot(M,N_intervals,legend_content,label_content,titile_figure,figure_n_c,I,fileadress,filename,save_fig_name)
marks=["-s","-o","-^","-v","-*","-p","->","-<","-d","-s","-o","-^"];
colors=["k","r","b","g","m","c","k","r","b","g","m","c"];
save_adress_name=strcat(fileadress,'\',filename,save_fig_name);
I=I+1;
II=I;
N=size(M,2)/2;%确定能画多少条曲线，X和Y是一起的
%% 画图
n_fg=figure(I);

t = tiledlayout(figure_n_c(1,1),figure_n_c(1,2),'TileSpacing','tight','Padding','tight');
for i=1:N%figure_n_c(1,1)*figure_n_c(1,2)
    nexttile
    maker_idx=1:N_intervals:size(M{1,2*i-1},1);%设置标记位置
    plot(M{1,2*i-1},M{1,2*i},marks(i),'color',colors(i),'MarkerIndices',maker_idx); %'visible','off'
    set(gca,'FontSize',10,'Fontname', 'Times New Roman');    
    legend(legend_content(i),'Interpreter','latex','Location','Southwest')
end
set(gcf,'position',[360,200,760,600]);%设置图创大小
set(0,'defaultfigurecolor','w');%设定背景颜色为白色
title(t,titile_figure,'Interpreter','latex')
xlabel(t,label_content(1),'Interpreter','latex')
ylabel(t,label_content(2),'Interpreter','latex')

%% 加边框
ax2 = axes('Position',get(gca,'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor','k','YColor','k');
set(ax2,'YTick', []);
set(ax2,'XTick', []);
%% 保存文件
savefig(figure(I),strcat(save_adress_name,'.fig'));
saveas(figure(I),strcat(save_adress_name,'.bmp'));
 delete(n_fg);
