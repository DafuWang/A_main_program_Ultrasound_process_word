function [value] = fivePoint1Order(Sig,h)
% 使用五点法求一阶导数
% Sig被求导的列向量
% h步长，单位为秒
lengSig = size(Sig,1);
value = zeros(lengSig-1,1);
% 边缘点使用差分，参考matlab梯度函数的做法
value(1,1) = (Sig(2,1) - Sig(1,1))/h;
 
for i = 1:lengSig-4
fivePoints = Sig(i:i+4,1);
f_2 = fivePoints(1,1);
f_1 = fivePoints(2,1);
f1 = fivePoints(4,1);
f2 = fivePoints(5,1);
value(i+1,1) = (f_2 - 8*f_1 + 8*f1 - f2)/(12*h);
end
value(i+2,1) = (Sig(i+3,1) - Sig(i+2,1))/h;
value(i+3,1) = (Sig(i+4,1) - Sig(i+3,1))/h;% 边缘点
end
