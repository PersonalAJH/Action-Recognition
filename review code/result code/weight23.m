% addpath('D:\2020.태권도 동작인식\21.08.01데이터정리\picture\마무리작업\matlab');

for i = sub
    cd('Z:\rv_data\06_Labeling_number\Xsens_number');
    clear cut_data;
    cut_data = readmatrix(sprintf('T%02d.xlsx',i));
    [m,n] = size(cut_data);
    if(m ~= 48)
        continue
    end
    
    
    for j =act
        path = 'Z:\rv_data\01_RawData\T'+string(sprintf('%02d',i)) + '\A' + string(sprintf('%02d',j)) + '\Mocap';
        cd(path);
        try
            clear tmp;
             tmp = readmatrix(sprintf('A%02d.xlsx',j),'Sheet',4);
             data_p = tmp;
            
            for t = 2:6
                 tmp = readmatrix(sprintf('A%02d.xlsx',j),'Sheet',t+3);
                 data_p = [data_p,tmp];
            end
            
        catch
            continue
        end

        
        [sample_num,trash] = size(tmp);
        if(abs(sample_num - cut_data(3*(j-1) + 1,1)) > 10)
           continue 
        end
        vel2 = sqrt(data_p(:,172).^2 + data_p(:,173).^2 + data_p(:,174).^2 + data_p(:,193).^2 + data_p(:,194).^2 + data_p(:,195).^2 + data_p(:,184).^2 + data_p(:,185).^2 + data_p(:,186).^2 + data_p(:,205).^2 + data_p(:,206).^2 + data_p(:,207).^2);
        
        try

            for iter = 1:3
                for iter2 = 1:4
                    if(isRfootFront(data_p,cut_data(3*(j-1) + iter,iter2+2)))
                        cd("D:\2020.태권도 동작인식\21.08.01데이터정리\picture\마무리작업\추가\23weight\pos\"+num2str(j)+"R");
                        frame_start = cut_data(3*(j-1)+iter,iter2+1);
                        frame_end =  cut_data(3*(j-1) + iter,iter2+2);
                        y = data_p(frame_start : frame_end,:);
                        weight = vel2(frame_start : frame_end,:);
                        data_r = weight_slow_func(y,weight);
                        data_tmp = data_p(frame_start : frame_end,:);
                        [sm,sn] = size(data_tmp);
                        [rm,rn] = size(data_r);
                        data_p(frame_start : frame_end,:) = data_r(rm-sm+1:end,:);
                        make_pos_pic(data_p,frame_start, frame_end,i,j);
                        cd("D:\2020.태권도 동작인식\21.08.01데이터정리\picture\마무리작업\추가\23weight\rot\"+num2str(j)+"R");
                        make_rot_pic(data_p,frame_start,frame_end,i,j);
                    else
                        cd("D:\2020.태권도 동작인식\21.08.01데이터정리\picture\마무리작업\추가\23weight\pos\"+num2str(j)+"L");
                        frame_start = cut_data(3*(j-1)+iter,iter2+1);
                        frame_end =  cut_data(3*(j-1) + iter,iter2+2);
                        y = data_p(frame_start : frame_end,:);
                        weight = vel2(frame_start : frame_end,:);
                        data_r = weight_slow_func(y,weight);
                        data_tmp = data_p(frame_start : frame_end,:);
                        [sm,sn] = size(data_tmp);
                        [rm,rn] = size(data_r);
                        data_p(frame_start : frame_end,:) = data_r(rm-sm+1:end,:);
                        make_pos_pic(data_p,frame_start, frame_end,i,j);
                        cd("D:\2020.태권도 동작인식\21.08.01데이터정리\picture\마무리작업\추가\23weight\rot\"+num2str(j)+"L");
                        make_rot_pic(data_p,frame_start, frame_end,i,j);
                    end
                end
            end
        catch
            continue
        end
    end
end




















