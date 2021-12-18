function [Position_Pend,Velocity_Pend] = SystemResponse()

        disp('Program Started');
        sim = remApi('remoteApi');
        sim.simxFinish(-1);
        clientID = sim.simxStart('127.0.0.1',19997,true,true,5000,5);

        if(clientID > -1)
            disp('Connected to remote API Server');
            
            [res1,Base_Joint] = sim.simxGetObjectHandle(clientID,'BASE_JOINT',sim.simx_opmode_blocking);
            [res2,Wheel_Joint] = sim.simxGetObjectHandle(clientID,'WHEEL_JOINT',sim.simx_opmode_blocking);
            [res3,Pend] = sim.simxGetObjectHandle(clientID,'PENDULUM',sim.simx_opmode_blocking);
            [res4,Wheel] = sim.simxGetObjectHandle(clientID,'WHEEL',sim.simx_opmode_blocking);


            sim.simxGetObjectOrientation(clientID,Pend,-1,sim.simx_opmode_streaming);
            sim.simxGetObjectVelocity(clientID,Pend,sim.simx_opmode_streaming);
            sim.simxGetObjectVelocity(clientID,Wheel,sim.simx_opmode_streaming);

            if( res1 == sim.simx_return_ok & res2 == sim.simx_return_ok & res3 == sim.simx_return_ok & res4 == sim.simx_return_ok)
                disp('Starting Collection')
                [res] = sim.simxSetJointTargetVelocity(clientID,Base_Joint,0,sim.simx_opmode_blocking);
                
                [rtnNum, pos_pend] = sim.simxGetObjectOrientation(clientID,Pend,-1,sim.simx_opmode_buffer);
                [rtnNum2, Linvel,Angvel] = sim.simxGetObjectVelocity(clientID, Pend, sim.simx_opmode_buffer);
                [rtnNum3, Linvel_wheel,Angvel_wheel] = sim.simxGetObjectVelocity(clientID, Wheel, sim.simx_opmode_buffer);
                Position_Pend = pos_pend(1)*(180/pi)
                Velocity_Pend = Angvel(1);
                Velocity_Wheel = Angvel_wheel(3);

                sim.simxFinish(-1);
            end

        end

        sim.delete();

end