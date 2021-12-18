function Wheel_Vel = DynamicsModel(Pos_Pend,Vel_Pend)
    format short
    Lc1 = 2.44; %meters from base
    L1 = 2.5; %m
    m1 = 19.53; %kg
    m2 = 10; %kg
    R = 2; %m 
    
    I1 = (1/3)*m1*L1^2;
    I2 = 0.5*m2*R;
    
    g = 9.81; %m/s^2
    mbar = m1*Lc1 + m2*L1;
    
    K1 = 0.5*m1*Lc1^2*Vel_Pend^2 + 0.5*I1*Vel_Pend^2;
    
    syms Vel_Wheel
    
    K2 = 0.5*m2*L1^2*Vel_Pend^2 + 0.5*I2*(Vel_Pend + Vel_Wheel)^2;
    P = g*mbar*(1 - cos(Pos_Pend));
    Vel_Sol = solve(K2 == K1 + P, Vel_Wheel);
    
    if(Pos_Pend < -0E-20)
        
        Wheel_Vel = Vel_Sol(1) + 1;
        
    elseif(Pos_Pend > 0E-20)
        
        Wheel_Vel = Vel_Sol(2) - 1;
    else
        Wheel_Vel = 0;
    end
    
end


