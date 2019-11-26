function temp = laser2Dto3D(p, inter, Rc_1, Tc_1)
%%1��������궨������Σ��õ��궨��ƽ�����������ϵ�µı�ʾ��
%%2Ȼ������������ཻ��ԭ������õ����ص��Ӧ����ά���ꡣ
%%%

%���ص������ƽ�浽��һ��ƽ��ת��
temp_n(1) = (p(1)-inter(1,3))/inter(1,1);
temp_n(2) = (p(2)-inter(2,3))/inter(2,2);

%����궨��ƽ�����������ϵ�µı�ʾax+by+cz+d=0
r = pinv(Rc_1);
a = r(3,1);
b = r(3,2);
c = r(3,3);
d = -(Tc_1(1)*a+ Tc_1(2)*b+ Tc_1(3)*c); 

%����2Dto3D
% Z = -d/(ax+by+c); X = x*Z; Y = y*Z;
t_z = -d/(a*temp_n(1)+b*temp_n(2)+c);
t_x=t_z*temp_n(1);
t_y=t_z*temp_n(2);

temp = [t_x; t_y; t_z];