function result = make_heat(data)
    [m,n] = size(data);   % n �� 2�ΰ��� �����ϰ� �ڵ带 «
    ma = max(max(data));
    process = zeros(ma,ma);
    result = zeros(ma,ma);
    for i = 1:m
         process = zeros(ma,ma);
         process(data(i,1),data(i,2)) = 1;
         result = result + process;
    end
end