
% addpath('D:\2020.�±ǵ� �����ν�\21.08.01����������\picture\�������۾�\matlab');


for i = sub % sub�� subject ���
    cd('Z:\rv_data\06_Labeling_number\Xsens_number');
    clear cut_data;
    cut_data = readmatrix(sprintf('T%02d.xlsx',i));
    [m,n] = size(cut_data);
    if(m ~= 48)
        continue
    end
    
    
    
    
    for j = act % act�� action ����
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
        
        
        try
            
            
            for iter = 1:3
                for iter2 = 1:4
                    if(isRfootFront(data_p,cut_data(3*(j-1) + iter,iter2+2)))
                        cd("D:\2020.�±ǵ� �����ν�\21.08.01����������\picture\�������۾�\�߰�\23normal\pos\"+num2str(j)+"R");
                        make_pos_pic(data_p,cut_data(3*(j-1) + iter,iter2+1), cut_data(3*(j-1) + iter,iter2+2),i,j);
                        cd("D:\2020.�±ǵ� �����ν�\21.08.01����������\picture\�������۾�\�߰�\23normal\rot\"+num2str(j)+"R");
                        make_rot_pic(data_p,cut_data(3*(j-1) + iter,iter2+1), cut_data(3*(j-1) + iter,iter2+2),i,j);
                    else
                        cd("D:\2020.�±ǵ� �����ν�\21.08.01����������\picture\�������۾�\�߰�\23normal\pos\"+num2str(j)+"L");
                        make_pos_pic(data_p,cut_data(3*(j-1) + iter,iter2+1), cut_data(3*(j-1) + iter,iter2+2),i,j);
                        cd("D:\2020.�±ǵ� �����ν�\21.08.01����������\picture\�������۾�\�߰�\23normal\rot\"+num2str(j)+"L");
                        make_rot_pic(data_p,cut_data(3*(j-1) + iter,iter2+1), cut_data(3*(j-1) + iter,iter2+2),i,j);
                    end
                end
            end
        catch
            continue
        end
        
        
    end
end





















