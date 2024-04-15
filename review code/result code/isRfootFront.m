function result = isRfootFront(data,time)

    %�޹� �������� �����Ѵ�.
    Rfoot = data(:,123).^2;
    Lfoot = data(:,135).^2;
    
    Ravg = mean(Rfoot(time-20:time));
    Lavg = mean(Lfoot(time-20:time));
    
    if(Ravg > Lavg)
        result = 1;
    else
        result = 0;
    end

end


