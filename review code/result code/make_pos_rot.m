function trash = make_pos_rot(data,frame_start,frame_end,i,j)

    pic(:,:,1) = data(frame_start:frame_end,2:70) - data(frame_start,2:70);
    pic(:,:,2) = data(frame_start:frame_end,282:350);
    pic(:,:,3) = data(frame_start:frame_end,352:420);
    
    lists = dir(cd);
    [m,n] = size(lists);
    img_name = m-1;
    imwrite(pic, sprintf('%d-%d-%d.png',img_name,i,j));
    img_name = img_name + 1;

end