function result = newisRfootFront(data)

    %�޹� �������� �����Ѵ�.
    Rfoot = data(:,53).^2;
    Lfoot = data(:,65).^2;
    
    Ravg = mean(Rfoot(1:20));
    Lavg = mean(Lfoot(1:20));
    
    if(Ravg > Lavg)
        result = 1;
    else
        result = 0;
    end

end


