function [II,I,save_adress_name,save_fig_name]=figure_distance_arrival_time(M,test_name,fileadress,filename,save_fig_name,figure_n_c,Colum,I)
N_intervals=200;
marks=["-s","-o","-^","-v","-*","-p","->","-<","-d","-s","-o","-^"];
colors=["k","r","b","g","m","c","k","r","b","g","m","c"];
 

for i=1:figure_n_c(1,1)*figure_n_c(1,2)
    legend_content(i)=strcat("$",test_name{1,Colum+i-1},"$");
end



label_content=["$Distance(mm)$","$arrival\,time(s)$"];
titile_figure='$Distance\,vs.\,arrival\,time$';

save_adress_name=strcat(fileadress,'\',filename,save_fig_name);
[II,I]=figure_plot(M,N_intervals,legend_content,marks,colors,label_content,titile_figure,save_adress_name,figure_n_c,I);
