function [Amp,test_number,t,N_test]=reading_orignal_data_from_excell(fileadress,filename)

NUM=readtable(strcat(fileadress,'\',filename,'.xlsx'));%读取excell数据
Amp=flipud(table2array(NUM(:,2:end)))';
test_number=flipud(table2cell(NUM(:,1)))';
N_test=size(Amp,2);

t(1)=0;
for i=1:size(NUM,2)-2
t(i+1)=t(i)+0.5E-6;
end
t=t';
