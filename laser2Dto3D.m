function temp = laser2Dto3D(p, inter, Rc_1, Tc_1)
%%1利用相机标定的内外参，得到标定板平面在相机坐标系下的表示；
%%2然后根据线与面相交的原理，计算得到像素点对应的三维坐标。
%%%

%像素点从物理平面到归一化平面转换
temp_n(1) = (p(1)-inter(1,3))/inter(1,1);
temp_n(2) = (p(2)-inter(2,3))/inter(2,2);

%计算标定板平面在相机坐标系下的表示ax+by+cz+d=0
r = pinv(Rc_1);
a = r(3,1);
b = r(3,2);
c = r(3,3);
d = -(Tc_1(1)*a+ Tc_1(2)*b+ Tc_1(3)*c); 

%计算2Dto3D
% Z = -d/(ax+by+c); X = x*Z; Y = y*Z;
t_z = -d/(a*temp_n(1)+b*temp_n(2)+c);
t_x=t_z*temp_n(1);
t_y=t_z*temp_n(2);

temp = [t_x; t_y; t_z];