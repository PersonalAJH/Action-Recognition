warning('off', 'all');
addpath("C:\Users\JH\Desktop\태권도 동작인식 데이터\review\code");
% 기본 폴더 경로 설정
baseFolder = 'C:\Users\JH\Desktop\태권도 동작인식 데이터\review\code';

% 파일을 읽을 TXX, AXX, sX 조합 설정
% TXX = {'T01', 'T02', 'T03'}; % 예시로 T01, T02, T03 사용



% Action number
% AXX = {'A06', 'A16'}; %  A06, A16
AXX = cell(1, 16); 
for i = 1:16
    AXX{i} = sprintf('A%02d', i);
end




% test number
TXX = cell(1, 42); 
for i = 1:42
    TXX{i} = sprintf('T%02d', i);
end

% 22번째 요소 제거
TXX(41) = [];
TXX(37) = [];
TXX(21) = [];
TXX(21) = [];


% action repetition number
sX = cell(1, 12); 
for i = 1:12
    sX{i} = sprintf('s%01d', i);
end

tmp = 0;

% sX = {'s1', 's2'}; % 예시로 s1, s2 사용

% 파일 읽기
for j = 1:length(AXX)
    for i = 1:length(TXX)
        for k = 1:length(sX)
            % Position 데이터 읽기
            positionFilePath = fullfile(baseFolder, 'Taekwondo_Xsens', 'split_Position', TXX{i}, AXX{j}, sprintf('%s_%s_%s.csv', TXX{i}, AXX{j}, sX{k}));
            data1_table = readtable(positionFilePath);
            data1 = table2array(data1_table);
            maxValue = mean(data1(:));
            stdDev = maxValue * 0.03; %에러 5%     
            noise = stdDev * randn(size(data1));
            noisy_data1 = data1 + noise;


            % Velocity 데이터 읽기
            velocityFilePath = fullfile(baseFolder, 'Taekwondo_Xsens', 'split_Velocity', TXX{i}, AXX{j}, sprintf('%s_%s_%s.csv', TXX{i}, AXX{j}, sX{k}));
            data2_table = readtable(velocityFilePath);
            data2 = table2array(data2_table);
            maxValue = mean(data2(:));
            stdDev = maxValue * 0.03; %에러 5%     
            noise = stdDev * randn(size(data2));
            noisy_data2 = data2 + noise;



            
            % Acceleration 데이터 읽기
            accelerationFilePath = fullfile(baseFolder, 'Taekwondo_Xsens', 'split_Acceleration', TXX{i}, AXX{j}, sprintf('%s_%s_%s.csv', TXX{i}, AXX{j}, sX{k}));
            data3_table = readtable(accelerationFilePath);
            data3 = table2array(data3_table);
            maxValue = mean(data3(:));
            stdDev = maxValue * 0.03; %에러 5%     
            noise = stdDev * randn(size(data3));
            noisy_data3 = data3 + noise;



            try
                weight = sqrt(noisy_data2(:,32).^2 + noisy_data2(:,33).^2 + noisy_data2(:,34).^2 + noisy_data2(:,53).^2 + noisy_data2(:,54).^2 + noisy_data2(:,55).^2 + noisy_data2(:,44).^2 + noisy_data2(:,45).^2 + noisy_data2(:,46).^2 + noisy_data2(:,65).^2 + noisy_data2(:,66).^2 + noisy_data2(:,67).^2);
                data_1w = weight_slow_func2(noisy_data1,weight);
                data_2w = weight_slow_func2(noisy_data2,weight);
                data_3w = weight_slow_func2(noisy_data3,weight);
            catch
                fprintf('error 반복 %d에서 에러 발생: %d %d %d \n',i,j,k);
            end


            basepicPath = 'C:\Users\JH\Desktop\태권도 동작인식 데이터\review\code\Taekwondo_Xsens\error3_picture';

            if mod(k, 2) == 1
                actionName = sprintf('%d%s', j, 'R');
            else
                actionName = sprintf('%d%s', j, 'L');
            end
                
            make_pic_folder = fullfile(basepicPath, actionName);
            cd(make_pic_folder);
            newmake_pos(data_1w,data_2w,data_3w);
            
        end
    end
end
