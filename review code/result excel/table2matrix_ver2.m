

[m,n] = size(data);
Re = zeros(m,n);


for i = 1:m
    for j = 1:n
        c = char(data(i,j));
        c = string(c);
        if(c =="1R")
            Re(i,j) = 1;
        elseif(c =="1L")
            Re(i,j) = 1;
            
        elseif(c =="2R")
            Re(i,j) = 2;
        elseif(c =="2L")
            Re(i,j) = 2;
        elseif(c =="3R")
            Re(i,j) = 3;
        elseif(c =="3L")
            Re(i,j) = 3;
         elseif(c =="4R")
            Re(i,j) = 4;
        elseif(c =="4L")
            Re(i,j) = 4;           
            
        elseif(c =="5R")
            Re(i,j) = 5;
        elseif(c =="5L")
            Re(i,j) = 5;
            
        elseif(c =="6R")
            Re(i,j) = 6;
        elseif(c =="6L")
            Re(i,j) = 6;
            
        elseif(c =="7R")
            Re(i,j) = 7;
        elseif(c =="7L")
            Re(i,j) = 7;
            
        elseif(c =="8R")
            Re(i,j) = 8;
        elseif(c =="8L")
            Re(i,j) = 8;
            
        elseif(c =="9R")
            Re(i,j) = 9;
        elseif(c =="9L")
            Re(i,j) = 9;
            
        elseif(c =="10R")
            Re(i,j) = 10;
        elseif(c =="10L")
            Re(i,j) = 10;
            
        elseif(c =="11R")
            Re(i,j) = 11;
        elseif(c =="11L")
            Re(i,j) = 11;
            
        elseif(c =="12R")
            Re(i,j) = 12;
        elseif(c =="12L")
            Re(i,j) = 12;
            
        elseif(c =="13R")
            Re(i,j) = 13;
        elseif(c =="13L")
            Re(i,j) = 13;
            
        elseif(c =="14R")
            Re(i,j) = 14;
        elseif(c =="14L")
            Re(i,j) = 14;
            
        elseif(c =="15R")
            Re(i,j) = 15;
        elseif(c =="15L")
            Re(i,j) = 15;
            
        elseif(c =="16R")
            Re(i,j) = 16;
        elseif(c =="16L")
            Re(i,j) = 16;

            
        end
    end
end