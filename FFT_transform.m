function [FFT_F,FFT_amp,FFT_phase,FFT_F_main,FFT_amp_main,FFT_phase_main]=FFT_transform(S,t)

N=size(t,1);  %采样点数
Fs=1/(t(2)-t(1));

Y = fft(S,N); %做FFT变换
Ayy = abs(Y); %取模
N05=round(N/2);

Ayy=Ayy/(N/2);   %换算成实际的幅度， 针对半频谱
Ayy(1)=Ayy(1)/2; %直流和奈奎斯特频率处还需要/2
F=((1:N)-1)*Fs/N; %换算成实际的频率值

FFT_F=F(1:N05)';
FFT_amp=Ayy(1:N05);

tol = 0.5;
Y(abs(Y)/(N/2) < tol) = 0;

Pyy=1:N05;
for i=1:N05
Pyy(i)=angle(Y(i)); %计算相位
Pyy(i)=Pyy(i)*180/pi; %换算为角度
end
FFT_phase=Pyy(1:N05)';

FFT_amp_main=max(FFT_amp);
[xx,yy]=find (FFT_amp ==max(max(FFT_amp)));
FFT_F_main=FFT_F(xx,yy);
FFT_phase_main=FFT_phase(xx,yy);






