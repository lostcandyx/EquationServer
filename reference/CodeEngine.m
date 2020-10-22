clear;clc;cla;

Test_project = GetProject('project1.txt');

f=inline('x/180.0*pi','x');%函数，角度变为弧度

set(gcf,'doublebuffer','on');    %gcf返回当前Figure对象的句柄值；打开双缓冲
%set(gcf,'units','normalized','position',[0.1 0.1 0.4 0.6]);
grid on;
hold on;
axis([-40  40  -40  40  -60 20]);
set(gca,'XTick',[-40:10:40]);
set(gca,'YTick',[-40:10:40]);
set(gca,'ZTick',[-60:10:20]);
xlabel('X');
ylabel('Y');
zlabel('Z');

%基础参数设置
RodDistance = 9;%相邻两臂间距
platform_radius = 25;%固定平台等效半径
actuator_radius = 9;%执行器等效半径
actuator_initial_z = -22;%初始执行器Z坐标

%机器人可视化
platform_o = Trans(0,0,0);
actuator_o = Trans(0,0,actuator_initial_z)*Rot(0,0,0);
platform = Hexagon(platform_o,asin((RodDistance/2)/platform_radius),platform_radius,'k');
actuator = Hexagon(actuator_o,asin((RodDistance/2)/actuator_radius),actuator_radius,'c');

roda_length = 10;%A杆长度（上杆）
rodb_length = 25;%B杆长度（下杆)
roda_color = 'r';
rodb_color = 'g';

%传统方式计算初始角度
a_1 = Distance(platform.P{1},actuator.P{1}*Trans(0,0,-actuator_initial_z))/Distance(platform.P{1},actuator.P{1});
a_2 = (Distance(platform.P{1},actuator.P{1}).^2 + roda_length.^2 - rodb_length.^2)/(2*Distance(platform.P{1},actuator.P{1})*roda_length);
servo_initial = pi - acos(a_1) - acos(a_2);
servo = [servo_initial;servo_initial;servo_initial;servo_initial;servo_initial;servo_initial];

index = [ 1 2 ; 2 3 ; 3 4 ; 4 5 ; 5 6 ; 6 1];
A_line = cell(6);
for i = 1:1:6
    A_line{i} = plot3(grabX(actuator.P{index(i,1)},actuator.P{index(i,2)}),grabY(actuator.P{index(i,1)},actuator.P{index(i,2)}),grabZ(actuator.P{index(i,1)},actuator.P{index(i,2)}),actuator.color,'linewidth',4,'linestyle','-');
end
P_line = cell(6);
for i = 1:1:6
    P_line{i} = plot3(grabX(platform.P{index(i,1)},platform.P{index(i,2)}),grabY(platform.P{index(i,1)},platform.P{index(i,2)}),grabZ(platform.P{index(i,1)},platform.P{index(i,2)}),platform.color,'linewidth',4,'linestyle','-');
end
R_line = cell(6,2);

for i = 1:1:6
    MID = platform.P{i}*Rot(0,servo(i),0)*Trans(roda_length,0,0);
    R_line{i,1} = plot3(grabX(platform.P{i},MID),grabY(platform.P{i},MID),grabZ(platform.P{i},MID),roda_color,'linewidth',4,'linestyle','-');
    R_line{i,2} = plot3(grabX(MID,actuator.P{i}),grabY(MID,actuator.P{i}),grabZ(MID,actuator.P{i}),rodb_color,'linewidth',4,'linestyle','-');
end

%S = IKsolve(platform.P{1},actuator.P{1},roda_length,rodb_length);
%disp(S);

R = 5;
frame = 1;
period = 0.01;
disp(Test_project);

pause(10);
while 1
    if frame > size(Test_project,1)
        break;
    end
    %运动分解+执行器重定位
    
    
    if Test_project(frame,1) == 3
        steps = Route(actuator,Test_project(frame,2),Test_project(frame,3),Test_project(frame,4));
        
        step = 1;
        while step <=  size(steps,1)
            actuator_o = actuator_o*Trans(steps(step,1),steps(step,2),steps(step,3));
            actuator.O = actuator_o;
            servo = PMsolver(actuator);
            
            %可视化
            plot3(actuator_o(1,4),actuator_o(2,4),actuator_o(3,4),'b.');
            for i = 1:1:6
                set(A_line{i},'XData',grabX(actuator.P{index(i,1)},actuator.P{index(i,2)}),...
                    'YData',grabY(actuator.P{index(i,1)},actuator.P{index(i,2)}),...
                    'ZData',grabZ(actuator.P{index(i,1)},actuator.P{index(i,2)}));
                MID = platform.P{i}*Rot(0,servo(i),0)*Trans(roda_length,0,0);
                set(R_line{i,1},'XData',grabX(platform.P{i},MID),'YData',grabY(platform.P{i},MID),'ZData',grabZ(platform.P{i},MID));
                set(R_line{i,2},'XData',grabX(MID,actuator.P{i}),'YData',grabY(MID,actuator.P{i}),'ZData',grabZ(MID,actuator.P{i}));
            end
            step = step + 1;
            pause(period);
        end
    elseif Test_project(frame,1) == 2
        period = Test_project(frame,2)/10;
    end
    frame = frame + 1;
end

function steps = Route(actuator,X,Y,Z)
steps = [];
step_length = 0.5;
STEP_length = 1;
location = [0 0 0];
x = X - actuator.O(1,4);
y = Y - actuator.O(2,4);
z = Z - actuator.O(3,4);
distance = (x^2 + y^2 + z^2)^0.5;
target = [x y z];
direction = [x/distance 0 0 ; 0 y/distance 0 ; 0 0 z/distance];
step = [step_length step_length step_length]*direction;
STEP = [STEP_length STEP_length STEP_length]*direction;
s = norm(step);
S = norm(STEP);
if distance <= (4*s+S)
    while norm(location)<(distance-s)
        steps = [ steps ; step];
        location  = location + step;
    end
    steps = [steps ; target-location];
else
    middle = distance - (2*s+S);
    steps = [ steps ; step];
    steps = [ steps ; step];
    location  = location + step*2;
    while norm(location) < middle
        steps = [ steps ; STEP];
        location  = location + STEP;
    end
    steps = [ steps ; (target-2*step-location)];
    steps = [ steps ; step];
    steps = [ steps ; step];
end
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


