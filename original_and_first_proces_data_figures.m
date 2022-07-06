function [I,II,Document,Content,Selection,Num,n_table,Distance,arrival_time,FFT_F_main,FFT_amp_main,FFT_phase_main]=original_and_proces_data_figures(I,Document,Content,Selection,Num,n_table,fileadress,filename,Amp,test_name,t,Colum_initial,Colum_end)


%%%%%%%%%%%%%%%%%%%%%%%%%%%数据处理%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N_intervals=200;

for i=1:Colum_end
    Amp1=Amp(:,i);
for j=3:size(Amp,1)-2
    if (abs(Amp1(j-2))+abs(Amp1(j-1))+abs(Amp1(j))+abs(Amp1(j+1))+abs(Amp1(j+2)))/5<=0.4/5
        Amp1(1:j)=0; 
    else
     arrival_time(i)=j*0.5E-6;
     break
    end 
end 
M_orignal_data{1,2*i-1}=t;M_orignal_data{1,2*i}=Amp(:,i);
M_wave{1,2*i-1}=t(j:end);M_wave{1,2*i}=Amp1(j:end);

[FFT_F,FFT_amp,FFT_phase,FFT_F_main(i),FFT_amp_main(i),FFT_phase_main(i)]=FFT_transform(Amp1(j:end),t(j:end));
M_FFT_amp{1,2*i-1}=FFT_F;M_FFT_amp{1,2*i}=FFT_amp;
M_FFT_phase{1,2*i-1}=FFT_F;M_FFT_phase{1,2*i}=FFT_phase;
end
Distance=[50:25:250]*1E-3;
M_distance_time{1,1}=Distance;M_distance_time{1,2}=arrival_time;
M_FFT_F_main{1,1}=[50:25:250]*1E-3;M_FFT_F_main{1,2}=FFT_F_main;
M_FFT_amp_main{1,1}=[50:25:250]*1E-3;M_FFT_amp_main{1,2}=FFT_amp_main;
M_FFT_phase_main{1,1}=[50:25:250]*1E-3;M_FFT_phase_main{1,2}=FFT_phase_main;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%时域原始数据%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure_n_c=[str2double('3'),str2double('3')];%子图排列
for i=1:figure_n_c(1,1)*figure_n_c(1,2)
    legend_content(i)=strcat("$",test_name{1,Colum_initial+i-1},"$");
end
label_content=["$Time(s)$","$Amplitude(\%)$"];
titile_figure='$Time\,vs.\,Amplitude$';
figure_save_name=strcat('Time domain function',legend_content(1));

[II,I,save_adress_name{1,1}]=figure_plot(M_orignal_data,N_intervals,legend_content,label_content,titile_figure,figure_n_c,I,fileadress,filename,figure_save_name);
%% 写入图片1
Selection.Start = Content.end;Selection.TypeParagraph;% 定义开始的位置为上一段结束的位置%换行插入内容并定义字体字号
n_rows=str2double('2');n_columns=str2double('1');
figure_title_word=strcat('时域原始数据',test_name{1,Colum_initial});
[Document,Selection,n_table,Num]=tables_figures_and_name(Document,Selection,save_adress_name,figure_save_name,figure_title_word,n_rows,n_columns,Num,n_table);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%超声时间和距离%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure_n_c=[str2double('1'),str2double('1')];%子图排列
for i=1:figure_n_c(1,1)*figure_n_c(1,2)
    legend_content(i)=strcat("$",test_name{1,Colum_initial+i-1},"$");
end
label_content=["$Distance(m)$","$Arrival\,time(s)$"];
titile_figure='$Distance\,vs.\,Arrival\,time$';
figure_save_name=strcat('Distance arrival time function',legend_content(1));

[II,I,save_adress_name{1,1}]=figure_plot(M_distance_time,N_intervals,legend_content,label_content,titile_figure,figure_n_c,I,fileadress,filename,figure_save_name);
%% 写入图片2
Selection.Start = Content.end;Selection.TypeParagraph;% 定义开始的位置为上一段结束的位置%换行插入内容并定义字体字号
n_rows=str2double('2');n_columns=str2double('1');
figure_title_word=strcat('超声时间和距离',test_name{1,Colum_initial});
[Document,Selection,n_table,Num]=tables_figures_and_name(Document,Selection,save_adress_name,figure_save_name,figure_title_word,n_rows,n_columns,Num,n_table);
%-------------------------------------插入表格------------------------------
Selection.Start = Content.end;Selection.TypeParagraph;% 定义开始的位置为上一段结束的位置%换行插入内容并定义字体字号
n_rows=str2double('3');n_columns=str2double('10');
table_name=strcat('超声时间和距离',test_name{1,Colum_initial});
table_content_t=["50mm","75mm","100mm","125mm","150mm","175mm","200mm","225mm","250mm","275mm"];
table_content_v=["Arrival time(s)"];
table_data=arrival_time;%[beta_joint',alpha_joint',ultimate_stress_joint',ultimate_strain_joint',R2_joint_beta',R2_joint_alpha'];
[n_table,Content,Num]=tables_Tables_and_name(Document,Content,Selection,n_rows,n_columns,table_data,table_name,table_content_t,table_content_v,Num,n_table);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%超声到达后时域函数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure_n_c=[str2double('3'),str2double('3')];%子图排列
for i=1:figure_n_c(1,1)*figure_n_c(1,2)
    legend_content(i)=strcat("$",test_name{1,Colum_initial+i-1},"$");
end
label_content=["$Time(s)$","$Amplitude(\%)$"];
titile_figure='$Time\,vs.\,Amplitude$';
figure_save_name=strcat('Time domain function without arrival time',legend_content(1));

[II,I,save_adress_name{1,1}]=figure_plot(M_wave,N_intervals,legend_content,label_content,titile_figure,figure_n_c,I,fileadress,filename,figure_save_name);
%% 写入图片3
Selection.Start = Content.end;Selection.TypeParagraph;% 定义开始的位置为上一段结束的位置%换行插入内容并定义字体字号
n_rows=str2double('2');n_columns=str2double('1');
figure_title_word=strcat('超声到达后时域函数',test_name{1,Colum_initial});
[Document,Selection,n_table,Num]=tables_figures_and_name(Document,Selection,save_adress_name,figure_save_name,figure_title_word,n_rows,n_columns,Num,n_table);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%频率和幅度%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure_n_c=[str2double('3'),str2double('3')];%子图排列
for i=1:figure_n_c(1,1)*figure_n_c(1,2)
    legend_content(i)=strcat("$",test_name{1,Colum_initial+i-1},"$");
end
label_content=["$Frequency(Hz)$","$Amplitude(\%)$"];
titile_figure='$Frequency\,vs.\,Amplitude$';
figure_save_name=strcat('Amplitude frequency domain function',legend_content(1));

[II,I,save_adress_name{1,1}]=figure_plot(M_FFT_amp,N_intervals,legend_content,label_content,titile_figure,figure_n_c,I,fileadress,filename,figure_save_name);
%% 写入图片4
Selection.Start = Content.end;Selection.TypeParagraph;% 定义开始的位置为上一段结束的位置%换行插入内容并定义字体字号
n_rows=str2double('2');n_columns=str2double('1');
figure_title_word=strcat('频率和幅度',test_name{1,Colum_initial});
[Document,Selection,n_table,Num]=tables_figures_and_name(Document,Selection,save_adress_name,figure_save_name,figure_title_word,n_rows,n_columns,Num,n_table);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%频率和相位%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure_n_c=[str2double('3'),str2double('3')];%子图排列
for i=1:figure_n_c(1,1)*figure_n_c(1,2)
    legend_content(i)=strcat("$",test_name{1,Colum_initial+i-1},"$");
end
label_content=["$Frequency(Hz)$","$Phase(\circ)$"];
titile_figure='$Frequency\,vs.\,Phase$';
figure_save_name=strcat('Phase frequency domain function',legend_content(1));

[II,I,save_adress_name{1,1}]=figure_plot(M_FFT_phase,N_intervals,legend_content,label_content,titile_figure,figure_n_c,I,fileadress,filename,figure_save_name);
%% 写入图片5
Selection.Start = Content.end;Selection.TypeParagraph;% 定义开始的位置为上一段结束的位置%换行插入内容并定义字体字号
n_rows=str2double('2');n_columns=str2double('1');
figure_title_word=strcat('频率和相位',test_name{1,Colum_initial});
[Document,Selection,n_table,Num]=tables_figures_and_name(Document,Selection,save_adress_name,figure_save_name,figure_title_word,n_rows,n_columns,Num,n_table);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%表面距离与主频率%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure_n_c=[str2double('1'),str2double('1')];%子图排列
for i=1:figure_n_c(1,1)*figure_n_c(1,2)
    legend_content(i)=strcat("$",test_name{1,Colum_initial+i-1},"$");
end
label_content=["$Distance(m)$","$Mian\,frequency(Hz)$"];
titile_figure='$Distance\,vs.\,Mian\,frequency$';
figure_save_name=strcat('Distance vs Mian frequency',legend_content(1));

[II,I,save_adress_name{1,1}]=figure_plot(M_FFT_F_main,N_intervals,legend_content,label_content,titile_figure,figure_n_c,I,fileadress,filename,figure_save_name);
%% 写入图片2
Selection.Start = Content.end;Selection.TypeParagraph;% 定义开始的位置为上一段结束的位置%换行插入内容并定义字体字号
n_rows=str2double('2');n_columns=str2double('1');
figure_title_word=strcat('表面距离与主频率',test_name{1,Colum_initial});
[Document,Selection,n_table,Num]=tables_figures_and_name(Document,Selection,save_adress_name,figure_save_name,figure_title_word,n_rows,n_columns,Num,n_table);
%-------------------------------------插入表格------------------------------
Selection.Start = Content.end;Selection.TypeParagraph;% 定义开始的位置为上一段结束的位置%换行插入内容并定义字体字号
n_rows=str2double('3');n_columns=str2double('10');
table_name=strcat('表面距离与主频率',test_name{1,Colum_initial});
table_content_t=["50mm","75mm","100mm","125mm","150mm","175mm","200mm","225mm","250mm","275mm"];
table_content_v=["Frequency(Hz)"];
table_data=FFT_F_main;%[beta_joint',alpha_joint',ultimate_stress_joint',ultimate_strain_joint',R2_joint_beta',R2_joint_alpha'];
[n_table,Content,Num]=tables_Tables_and_name(Document,Content,Selection,n_rows,n_columns,table_data,table_name,table_content_t,table_content_v,Num,n_table);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%表面距离与主幅度%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure_n_c=[str2double('1'),str2double('1')];%子图排列
for i=1:figure_n_c(1,1)*figure_n_c(1,2)
    legend_content(i)=strcat("$",test_name{1,Colum_initial+i-1},"$");
end
label_content=["$Distance(m)$","$Mian\,amplitude(\%)$"];
titile_figure='$Distance\,vs.\,Mian\,amplitude$';
figure_save_name=strcat('Distance vs Mian amplitude',legend_content(1));

[II,I,save_adress_name{1,1}]=figure_plot(M_FFT_amp_main,N_intervals,legend_content,label_content,titile_figure,figure_n_c,I,fileadress,filename,figure_save_name);
%% 写入图片2
Selection.Start = Content.end;Selection.TypeParagraph;% 定义开始的位置为上一段结束的位置%换行插入内容并定义字体字号
n_rows=str2double('2');n_columns=str2double('1');
figure_title_word=strcat('表面距离与主幅度',test_name{1,Colum_initial});
[Document,Selection,n_table,Num]=tables_figures_and_name(Document,Selection,save_adress_name,figure_save_name,figure_title_word,n_rows,n_columns,Num,n_table);
%-------------------------------------插入表格------------------------------
Selection.Start = Content.end;Selection.TypeParagraph;% 定义开始的位置为上一段结束的位置%换行插入内容并定义字体字号
n_rows=str2double('3');n_columns=str2double('10');
table_name=strcat('表面距离与主幅度',test_name{1,Colum_initial});
table_content_t=["50mm","75mm","100mm","125mm","150mm","175mm","200mm","225mm","250mm","275mm"];
table_content_v=["Amplitude(\%)"];
table_data=FFT_amp_main;%[beta_joint',alpha_joint',ultimate_stress_joint',ultimate_strain_joint',R2_joint_beta',R2_joint_alpha'];
[n_table,Content,Num]=tables_Tables_and_name(Document,Content,Selection,n_rows,n_columns,table_data,table_name,table_content_t,table_content_v,Num,n_table);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%表面距离与主相位%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure_n_c=[str2double('1'),str2double('1')];%子图排列
for i=1:figure_n_c(1,1)*figure_n_c(1,2)
    legend_content(i)=strcat("$",test_name{1,Colum_initial+i-1},"$");
end
label_content=["$Distance(m)$","$Mian\,Phase(\circ)$"];
titile_figure='$Distance\,vs.\,Mian\,phase$';
figure_save_name=strcat('Distance vs Mian phase',legend_content(1));

[II,I,save_adress_name{1,1}]=figure_plot(M_FFT_phase_main,N_intervals,legend_content,label_content,titile_figure,figure_n_c,I,fileadress,filename,figure_save_name);
%% 写入图片2
Selection.Start = Content.end;Selection.TypeParagraph;% 定义开始的位置为上一段结束的位置%换行插入内容并定义字体字号
n_rows=str2double('2');n_columns=str2double('1');
figure_title_word=strcat('表面距离与主相位',test_name{1,Colum_initial});
[Document,Selection,n_table,Num]=tables_figures_and_name(Document,Selection,save_adress_name,figure_save_name,figure_title_word,n_rows,n_columns,Num,n_table);
%-------------------------------------插入表格------------------------------
Selection.Start = Content.end;Selection.TypeParagraph;% 定义开始的位置为上一段结束的位置%换行插入内容并定义字体字号
n_rows=str2double('3');n_columns=str2double('10');
table_name=strcat('表面距离与主相位',test_name{1,Colum_initial});
table_content_t=["50mm","75mm","100mm","125mm","150mm","175mm","200mm","225mm","250mm","275mm"];
table_content_v=["Phase(\circ)"];
table_data=FFT_phase_main;%[beta_joint',alpha_joint',ultimate_stress_joint',ultimate_strain_joint',R2_joint_beta',R2_joint_alpha'];
[n_table,Content,Num]=tables_Tables_and_name(Document,Content,Selection,n_rows,n_columns,table_data,table_name,table_content_t,table_content_v,Num,n_table);

