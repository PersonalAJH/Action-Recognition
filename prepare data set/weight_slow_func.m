function weight = weight_slow_func(data, weight_func)

%�̾ȿ� ������ �ִ� (��ȯx, func(x))�� �ְ� ���������̼��� ������ ����
% func���� �ٽ� �����ͼ� ����ؾ���
[m,n] = size(weight_func);
if(m>n)
    sample_num = m;
else
    sample_num = m;
    %         sample_num = n;
end

integral = zeros(1,sample_num);

if(m>n)
    for i = 1: sample_num
        integral(:,i) = sum(weight_func(1:i,:));
    end
else
    
    for i = 1: sample_num
        integral(:,i) = sum(weight_func(1:i,:));
    end
    %         for i = 1: sample_num
    %             integral(:,i) = sum(weight_func(:,1:i));
    %         end
end

sum_all = sum(weight_func);


x = 0:sample_num;
xx = 0: 0.5 : sample_num;

for i = 1:sample_num
    t(i,:) = sample_num*integral(:,i)/sum_all;
end

xx = 0:sample_num;
xx= transpose(xx);
for j = 1:420
yy(:,j)= spline(t,data(:,j),xx);
end
%     xxx = 0:sample_num;
%     yyy = spline(yy,data,xxx);

weight = yy;

end