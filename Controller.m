function Controller(Wheel_Vel)
    sim = remApi('remoteApi');
    sim.simxFinish(-1);
    clientID = sim.simxStart('127.0.0.1',19997,true,true,5000,5);
    
    if(clientID > -1)
        [res,Wheel_Joint] = sim.simxGetObjectHandle(clientID,'WHEEL_JOINT',sim.simx_opmode_blocking);
        [res2,Pend] = sim.simxGetObjectHandle(clientID,'PENDULUM',sim.simx_opmode_blocking);
        sim.simxGetObjectVelocity(clientID,Pend,sim.simx_opmode_streaming);
        if(res == sim.simx_return_ok & res2 == sim.simx_return_ok)
            [Res] = sim.simxSetJointTargetVelocity(clientID,Wheel_Joint,Wheel_Vel,sim.simx_opmode_blocking);
            [Res2,Base_Vel] = sim.simxGetObjectVelocity(clientID,Pend,sim.simx_opmode_buffer);
        end
        sim.simxFinish(-1);
    end
    sim.delete();
end
