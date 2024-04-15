function weight = weight_slow_func(data, weight_func)

%이안에 이전에 있던 (변환x, func(x))를 넣고 인터폴레이션을 진행한 값을
% func으로 다시 가져와서 사용해야함
[m,n] = size(weight_func);

sample_num = m;
integral = zeros(1,sample_num);


for i = 1: sample_num
    integral(:,i) = sum(weight_func(1:i,:));
end

sum_all = sum(weight_func);

for i = 1:sample_num
    t(i,:) = sample_num*integral(:,i)/sum_all;
end

xx = 0:sample_num;
xx= transpose(xx);
for j = 1:70
yy(:,j)= spline(t,data(:,j),xx);
end

weight = yy;

end