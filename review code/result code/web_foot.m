addpath('D:\2020.태권도 동작인식\21.08.01데이터정리');


for i  = 21%: 42
    cd('Z:\rv_data\06_Labeling_number\Xsens_number');
    cut_data = xlsread(sprintf('T%02d.xlsx',i));
    for act_num = 14
        
        path = 'Z:\rv_data\01_RawData\T'+string(sprintf('%02d',i)) + '\A' + string(sprintf('%02d',act_num)) + '\Mocap';
        cd(path);
        
        clear tmp;
        tmp = readmatrix(sprintf('A%02d.xlsx',act_num),'Sheet',4);
        data_p = tmp;
        
        for t = 2:6
            
            tmp = readmatrix(sprintf('A%02d.xlsx',act_num),'Sheet',t+3);
            data_p = [data_p,tmp];
        end
        
        exp_tmp = ['a',num2str(act_num),' = data_p;'];
        eval(exp_tmp);
        
        exp_tmp = ['Foot_proceed = a',num2str(act_num),'(:,193) + a',num2str(act_num),'(:,205);'];
        eval(exp_tmp);    
        
        
        act_num
        exp_tmp = ['Foot_proceed = a',num2str(act_num),'(:,193) + a',num2str(act_num),'(:,205);'];
        eval(exp_tmp);
        
        %% position
        
        %RIght foot
        
        exp_tmp = ['R',num2str(act_num),' = a', num2str(act_num), '(:,172).^2 + a',num2str(act_num),'(:,173).^2 + a',num2str(act_num),'(:,174).^2 + a',num2str(act_num),'(:,193).^2 + a',num2str(act_num),'(:,194).^2 + a',num2str(act_num),'(:,195).^2;'];
        eval(exp_tmp);
        
        exp_tmp = ['L',num2str(act_num),' = a', num2str(act_num), '(:,184).^2 + a',num2str(act_num),'(:,185).^2 + a',num2str(act_num),'(:,186).^2 + a',num2str(act_num),'(:,205).^2 + a',num2str(act_num),'(:,206).^2 + a',num2str(act_num),'(:,207).^2;'];
        eval(exp_tmp);
        
        
        exp_tmp = ['FootFront = R',num2str(act_num),' + L',num2str(act_num),';'];
        eval(exp_tmp)
        
        FootFront =  circshift(FootFront,8) + circshift(FootFront,7) + circshift(FootFront,6) + circshift(FootFront,5) + circshift(FootFront,4) + circshift(FootFront,3) + circshift(FootFront,2) + circshift(FootFront,1) + circshift(FootFront,0) + circshift(FootFront,-1)+ circshift(FootFront,-2)+ circshift(FootFront,-3)+ circshift(FootFront,-4) + circshift(FootFront,-5)+ circshift(FootFront,-6)+ circshift(FootFront,-7)+ circshift(FootFront,-8);
        FootFront =  circshift(FootFront,8) + circshift(FootFront,7) + circshift(FootFront,6) + circshift(FootFront,5) + circshift(FootFront,4) + circshift(FootFront,3) + circshift(FootFront,2) + circshift(FootFront,1) + circshift(FootFront,0) + circshift(FootFront,-1)+ circshift(FootFront,-2)+ circshift(FootFront,-3)+ circshift(FootFront,-4) + circshift(FootFront,-5)+ circshift(FootFront,-6)+ circshift(FootFront,-7)+ circshift(FootFront,-8);
        FootFront =  circshift(FootFront,8) + circshift(FootFront,7) + circshift(FootFront,6) + circshift(FootFront,5) + circshift(FootFront,4) + circshift(FootFront,3) + circshift(FootFront,2) + circshift(FootFront,1) + circshift(FootFront,0) + circshift(FootFront,-1)+ circshift(FootFront,-2)+ circshift(FootFront,-3)+ circshift(FootFront,-4) + circshift(FootFront,-5)+ circshift(FootFront,-6)+ circshift(FootFront,-7)+ circshift(FootFront,-8);
        TF = islocalmin(FootFront);
        
%         [m,n] = size(a2);
        
        exp_tmp = ['[m,n] = size(a',num2str(act_num),');'];
        eval(exp_tmp);
        
        
        condition = 1;
        coeff = 0;
        delay = 0 ;
        condition2 = 0;
        while(condition == 1)
            data_num = 0;
            coeff = coeff + 0.0002;
            coeff
            
            x = 1:m;
            C = islocalmin(FootFront);
            D = FootFront < coeff*max(FootFront);
            E = and(C,D);                 %E를 최종적으로 사용하면됨
            
            point = x(E);
            
            
            
            [point_m,point_y] = size(point);
            stamp1 = zeros(1,point_y-1);
            stamp2 = zeros(1,point_y-1);
            
            
            for i = 1:point_y-1
                stamp1(1,i) =  point(1,i+1) - point(1,i);
            end
            
            [tmp,tmp_stamp] = size(stamp1);
            tmp_median_value = zeros(1,1);
            tmp_count = 1;
            for i = 1:tmp_stamp
                if(stamp1(1,i) >100)
                    tmp_median_value(1,tmp_count) = stamp1(1,i);
                    tmp_count = tmp_count +1;
                end
            end
            
            med = median(tmp_median_value);
            F = stamp1 < med*2.0;
            G = stamp1 > med*0.8;
            
            H = and(F,G);
            
            for i = 1:point_y-1
                stamp2(1,i) =  max(FootFront(point(1,i):point(1,i+1),1));
            end
            
            
            max_value = maxk(stamp2,12);
            [test1, test2] = size(max_value);
            
            if(test2 > 11)
                max_value = max_value(1,8);
            else
                max_value = 1 ; % max_value(1,1);
            end
            I = stamp2 > 0.7*max_value;
            
            J = and(H,I);
            J2 = J;
            J2 = [false,J2];
            J2 = logical(J2);
            
            aa = point(J);
            aa2 = point(J2);
            [trash,act_size] = size(aa2);
            
            %     plot(Footstamp(:,135))
            
            exp_tmp = ['LFtmp = a', num2str(act_num), '(:,135).^2;'];
            eval(exp_tmp);
            exp_tmp = ['RFtmp = a', num2str(act_num), '(:,123).^2;'];
            eval(exp_tmp);
            
            for k = 1:act_size
                xx = x(1,aa(1,k):aa2(1,k));
                if(mean(Foot_proceed(xx)) >0)
                    data_num = data_num + 1;
                end
            end
            
            if(data_num == 12)
                condition2 = 1;
                break;
            end
            
            delay = delay + 1;
            if(delay > 200)
                condition2 = 1;
                break;
            end
            
            %         condition = 0;
        end
        
        
        [trash,plot_size] = size(aa2);
%         subplot(4,4,act_num)
        
        plot(x,FootFront,'k')%,x(E),FootFront(E),'r*')
        hold on
        plot(x(E),FootFront(E),'r*');
        
        
        
        substract = zeros(1,1);
        for i = 1:plot_size
            xx = x(1,aa(1,i):aa2(1,i));
            if(mean(Foot_proceed(xx)) >0)
                
                plot(xx,FootFront(xx),'r')
            else
                substract = [i,substract];
            end
        end
        
        [trash, subs_size] = size(substract);
        if(subs_size >1)
            for i = 1:subs_size-1
                aa(:,substract(1,i)) = [];
                aa2(:,substract(1,i)) = [];
            end
        end
        
        
        tmp_title = num2str(act_num);
        title(tmp_title)
        
        [trash, aa_size] = size(aa);
        if(aa_size == 12)
            aa3 = [aa,aa2(1,12)];
        else
            aa3 = zeros(1,13);
        end
        
        if(act_num == 1)
            cut_list = aa3;
        else
            cut_list = [cut_list;aa3];
        end
        
        
    end
    
    
    
    
end







