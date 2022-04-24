# Action-Recognition
Taekwondo action recognition algorithm for personal project
data set is acquired by Xsens MTX suit data
data set is composed 23 body parts position, velocity, acceleration, angle, angular velocity, angular acceleration etc....
data set code in prepare data set folder is algorithm that split entire experiment data to one unit action
isRFootFront.m : When one unit action is ended, which foot is front in Right or Left
make_pos, rot pic : Convert one unit action to one image position or rotation
web_foot : entire experiment split to one unit action algorithm( Checking subject is stop for seconds)
normal 23 : overall process of this experiment
