function  [I2]=Data_save( Distance,arrival_time,FFT_F,FFT_amp,FFT_phase,FFT_F_main,FFT_amp_main,FFT_phase_main,sheet_number,group,fileadress,filename)

% 原始数据储存，便以用origin画图
excel_adress_name=strcat(fileadress,'\',filename,'(processed data)','.xlsx');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%AAAAAAAAAAAAAAA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I2=1;%用于计量表中的列
xlswrite(excel_adress_name,{'试验数据类型'},sheet_number,strcat(char(65+I2-1),'1'));%写入样本
xlswrite(excel_adress_name,{strcat('超声处理数据',group,'方向')},sheet_number,strcat(char(65+I2-1),'2'));%样本名
xlswrite(excel_adress_name,{'样品名'},sheet_number,strcat(char(65+I2-1),'3'));%写入样本
xlswrite(excel_adress_name,{filename},sheet_number,strcat(char(65+I2-1),'4'));%样本名
I2=I2+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

name_data=[string(strcat('Distance_',group)),string(strcat('arrival_time_',group)),string(strcat('FFT_F_main_',group)),string(strcat('FFT_amp_main_',group)),string(strcat('FFT_phase_main_',group))];
fitted_and_original_data={Distance',arrival_time',FFT_F_main',FFT_amp_main',FFT_phase_main'};
[I2]=data_save_column_loop(excel_adress_name,sheet_number,name_data,fitted_and_original_data,I2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I2=I2+1;%空一列
NN=size(FFT_F,2);
for i=1:NN
    name_data1(3*i-2)=string(strcat('FFT_F_',group,'1',num2str(i)));
    name_data1(3*i-1)=string(strcat('FFT_amp_',group,'1',num2str(i)));
    name_data1(3*i)=string(strcat('FFT_phase_',group,'1',num2str(i)));
end

fitted_and_original_data1=cell(1,NN);
for i=1:NN
    fitted_and_original_data1{1,3*i-2}=FFT_F{i};
    fitted_and_original_data1{1,3*i-1}=FFT_amp{i};
    fitted_and_original_data1{1,3*i}=FFT_phase{i};
end
[I2]=data_save_column_loop(excel_adress_name,sheet_number,name_data1,fitted_and_original_data1,I2);


