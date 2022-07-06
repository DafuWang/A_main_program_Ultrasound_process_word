% clear
clc
close all; %先关闭所有图片
% %%%%%%%%%%%%%%%%%%%%%%%%%%%应力应变数据处理%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clc
tic
%% %%%%%%%%%%%%%%%%%%%%%%%%%原始数据文件名和地址输入%%%%%%%%%%%%%%%%%%%%%%%%%
filename='C30-4-24';
fileadress0='D:\大论文\超声波测试\20211213 24MONTH\数据处理\';
fileadress=strcat(fileadress0,filename);
N=2;%需修改，1:绝对时间，2:相对时间%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filespec_user = (strcat(fileadress0,filename,'.doc'));% 设定测试Word文件名和路径
[Word,Document,Content,Selection]=word_active_and_open(filespec_user);%word得激活和创建
L=word_PageSetup(Document);%% 页面设置
Content.Start = 0;%设定光标位置
Paragraphformat = Selection.ParagraphFormat;

Num.figures=1;n_table=1;Num.equation=1;Num.Table=1;Num.refer=1;%用于记录图片、表格、公式、参考文献得个数
%% %%%%%%%%%%%%%%%%%%%%%%%%标题%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
title = strcat(filename,'的超声数据处理报告');
Content.Text = title;L=set_format_title1(Content);%字体和段落格式设定 
%% 
n_title2=1;n_title3=1;n_title4=1;%用于记录二级，三级，四级标题
Selection.Start = Content.end;Selection.TypeParagraph;% 定义开始的位置为上一段结束的位置%换行插入内容并定义字体字号
Title1 = strcat(num2str(n_title2),'. 原始数据');n_title2=n_title2+1;
Selection.Text = Title1;L=set_format_title2(Selection);%格式设定

Selection.Start = Content.end;Selection.TypeParagraph;% 定义开始的位置为上一段结束的位置%换行插入内容并定义字体字号
[T1_content] =Title1_content();

for i=1:size(T1_content)%不同段落的写入
Selection.Text = T1_content{i,1};L=set_format_for_text(Selection);
Selection.Start = Content.end;Selection.TypeParagraph;
end
%% %%%%%%%%%%%%原始数据读取%%%%%%%%%%%%%%
[Amp,test_name,t,N_test]=reading_orignal_data_from_excell(fileadress,filename);
%% %%%%%%%%%%%%原始数据画图%%%%%%%%%%%%%%
I=1;
Colum_initial_0=[1,10,19,23,27,38,49,50];
Colum_unmber_0= [9,9, 4, 4, 11,11,1,11];
distance{1}=["50mm","75mm","100mm","125mm","150mm","175mm","200mm","225mm","250mm"];%单位为毫米
distance{2}=distance{1};
distance{3}=["50mm","75mm","100mm","125mm"];
distance{4}=distance{3};
distance{5}=["71mm","90mm","112mm","135mm","158mm","182mm","206mm","231mm","255mm","280mm","304mm"];%单位为毫米
distance{6}=distance{5};
distance{7}="300mm";
distance{8}=["25mm","50mm","75mm","100mm","125mm","150mm","175mm","200mm","225mm","250mm","275mm"];%单位为毫米


figure_n_c=[3,3;3,3;2,2;2,2;4,3;4,3;1,1;4,3];


% for i=1:8
% Colum_initial=Colum_initial_0(i);
% Colum_unmber=Colum_unmber_0(i);
% group=char(64+i);
% 
% [I,II,Document,Content,Selection,Num,n_table,Distance0,arrival_time0,FFT_F0,FFT_amp0,FFT_phase0,FFT_F_main0,FFT_amp_main0,FFT_phase_main0]=original_and_processed_data(I,Document,Content,Selection,Num,n_table,fileadress,filename,group,Amp,figure_n_c(i,:),test_name,t,distance{i},Colum_initial,Colum_unmber);
% eval(['Distance_',group,'=','Distance0',';'])
% eval(['arrival_time_',group,'=','arrival_time0',';'])
% 
% eval(['FFT_F_',group,'=','FFT_F0',';'])
% eval(['FFT_amp_',group,'=','FFT_amp0',';'])
% eval(['FFT_phase_',group,'=','FFT_phase0',';'])
% eval(['FFT_F_main_',group,'=','FFT_F_main0',';'])
% eval(['FFT_amp_main_',group,'=','FFT_amp_main0',';'])
% eval(['FFT_phase_main_',group,'=','FFT_phase_main0',';'])
% end

for i=1:8
sheet_number=strcat('sheet',num2str(i));
group=char(64+i);
Distance=eval(['Distance_',group]);
arrival_time=eval(['Distance_',group]);
FFT_F=eval(['FFT_F_',group]);
FFT_amp=eval(['FFT_amp_',group]);
FFT_phase=eval(['FFT_phase_',group]);
FFT_F_main=eval(['FFT_F_main_',group]);
FFT_amp_main=eval(['FFT_amp_main_',group]);
FFT_phase_main=eval(['FFT_phase_main_',group]);
[I2]=Data_save(Distance,arrival_time,FFT_F,FFT_amp,FFT_phase,FFT_F_main,FFT_amp_main,FFT_phase_main,sheet_number,group,fileadress,filename);
end






