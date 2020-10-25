function Output = PMsolver(actuator)

f=inline('x/180.0*pi','x');%函数，角度变为弧度

%基础参数设置
RodDistance = 9;%相邻两臂间距
platform_radius = 25;%固定平台等效半径

%生成平台
platform_o = Trans(0,0,0);
platform = Hexagon(platform_o,asin((RodDistance/2)/platform_radius),platform_radius,'k');

roda_length = 10;%A杆长度（上杆）
rodb_length = 25;%B杆长度（下杆)

servo  = zeros(6);

for i = 1:1:6
    servo(i)=IKsolve(platform.P{i},actuator.P{i});
end

Output = servo;

    function R = IKsolve(P1,P3)
        L1 = roda_length;
        L2 = rodb_length;
        P_11 = P1(1,1);P_12 = P1(1,2);P_13 = P1(1,3);P_14 = P1(1,4);
        P_21 = P1(2,1);P_22 = P1(2,2);P_23 = P1(2,3);P_24 = P1(2,4);
        P_31 = P1(3,1);P_32 = P1(3,2);P_33 = P1(3,3);P_34 = P1(3,4);
        P3_1 = P3(1,4);P3_2 = P3(2,4);P3_3 = P3(3,4);
        z = 1;
        %load equation.mat;
        E = zeros(4,1);
        a = 2*L1*P_21*P_24*z^4 + 2*L1*P_11*P_14*z^4 - 2*L1*P3_2*P_21*z^4 - 2*L1*P3_1*P_11*z^4 + 2*P3_2*P_24*z^4 + 2*P3_1*P_14*z^4 + L2^2*z^4 - L1^2*P_21^2*z^4 - L1^2*P_11^2*z^4 - P_24^2*z^4 - P_14^2*z^4 - P3_3^2*z^4 - P3_2^2*z^4 - P3_1^2*z^4;
        b = - 4*L1*P3_3;
        b = b/a;
        c = 4*P3_2*P_24*z^2 + 4*P3_1*P_14*z^2 + 2*L1^2*P_21^2*z^2 + 2*L1^2*P_11^2*z^2 - 2*P_24^2*z^2 - 2*P_14^2*z^2 - 2*P3_3^2*z^2 - 2*P3_2^2*z^2 - 2*P3_1^2*z^2 - 4*L1^2*z^2 + 2*L2^2*z^2;
        c = c/a;
        d = - 4*L1*P3_3;
        d = d/a;
        e = - 2*L1*P_21*P_24 - 2*L1*P_11*P_14 + 2*L1*P3_2*P_21 + 2*L1*P3_1*P_11 + 2*P3_2*P_24 + 2*P3_1*P_14 - L1^2*P_21^2 - L1^2*P_11^2 - P_24^2 - P_14^2 - P3_3^2 - P3_2^2 - P3_1^2 + L2^2;
        e = e/a;
        
        solutions = QuarticSolve(b,c,d,e);
        %disp(solutions());
        real_solution = [];
        
        for j = 1:1:4
            if solutions(2*j)==0
                real_solution = [real_solution solutions(1,2*j-1)];
            end
        end
        
        R = 2*max(atan(real_solution));
    end

    function X = grabX(T1,T2)%提取X数值
        X = [T1(1,4) T2(1,4)];
    end

    function Y = grabY(T1,T2)%提取Y数值
        Y = [T1(2,4) T2(2,4)];
    end

    function Z = grabZ(T1,T2)%提取Z数值
        Z = [T1(3,4) T2(3,4)];
    end

end
