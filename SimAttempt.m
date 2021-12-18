clear;
clc;

t = clock;
startTime = t(6);
currentTime = t(6);
TLeft = 0;

while (TLeft < 15 || TLeft > 0) 
           [Position_Pend, Velocity_Pend] = SystemResponse();
           Wheel_Vel = DynamicsModel(Position_Pend,Velocity_Pend);
           Controller(Wheel_Vel);
           c = clock;
           currentTime = c(6);
           TLeft = currentTime-startTime
end
