function trash = newmake_pos(data1,data2,data3,i)

    pic(:,:,1) = data1(:,2:70) - data1(1,2:70);
    pic(:,:,2) = data2(:,2:70);
    pic(:,:,3) = data3(:,2:70);
    
%     if newisRfootFront(data1) == 1
%         if i == 1
%             cd("C:\Users\JH\Desktop\태권도 동작인식 데이터\review\code\Taekwondo_Xsens\Action6_right")
%         else
%             cd("C:\Users\JH\Desktop\태권도 동작인식 데이터\review\code\Taekwondo_Xsens\Action16_right")
%         end
%     else
%         if i == 1
%             cd("C:\Users\JH\Desktop\태권도 동작인식 데이터\review\code\Taekwondo_Xsens\Action6_left")
%         else
%             cd("C:\Users\JH\Desktop\태권도 동작인식 데이터\review\code\Taekwondo_Xsens\Action16_left")
%         end
%     end



    lists = dir(cd);
    [m,n] = size(lists);
    img_name = m-1;
    imwrite(pic, sprintf('%d.png',img_name));

end