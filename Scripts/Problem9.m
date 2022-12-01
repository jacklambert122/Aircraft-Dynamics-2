%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Jack Lambert
% Aircraft Dynmaics Homework 2
% Problem 9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Globals
global mass g R k eta zeta alpha beta Ix Iy Iz f1 f2 f3 f4 

%% Constants
mass = 68/1000; % [kg]
L_arm = 6/100; % [m]
eta = 1*10^(-3); % Aerodynamic Coefficient for drag [N /(m/s)^2]
zeta = 3*1^(-3);  % Aerodynamic Coefficient for drag [N /(m/s)^2]
alpha = 2*10^(-6); % Aerodynamic Coefficient for drag [N /(rad/s)^2]
beta = 1*10^(-6); % Aerodynamic Coefficient for drag [N /(rad/s)^2]
Ix = 6.8*10^(-5); % MOI about x-axis [kg*m^2]
Iy = 9.2*10^(-5); % MOI about x-axis [kg*m^2]
Iz = 1.35*10^(-4); % MOI about x-axis [kg*m^2]
R = sqrt(2)/2*L_arm; % Distance to COG [m]
k = 0.0024; % [m]
g = 9.81; % [m/s^2]

%% Initial Conditions
condition(1) = 0; % N - location [m]
condition(2) = 0; % E - location [m]
condition(3) = 0; % -D - location [m]
condition(4) = 0; % u - component of velocity [m/s]
condition(5) = 0; % v compenent of velocity [m/s]
condition(6) = 0; % w component of velocity [m/s]

% Rotational Motion
condition(7) = 0; % Phi Euler Angle [rad]
condition(8) = 0; % Theta Euler Angle [rad]
condition(9) = 0; % Psi Euler Angle [rad]
condition(10) = 0; % Angular velocity about the x-axis [rad/s]
condition(11) = 0; % Angular Velocity about the y-axis [rad/s]
condition(12) = 0; % Angular Velocity about the z-axis [rad/s]

%% Solving Differential Equations w/ ODE45
f1 = (mass*g)/4; % Force for steady Level Flight about Motor 1
f2 = (mass*g)/4; % Force for steady Level Flight about Motor 1
f3 = (mass*g)/4; % Force for steady Level Flight about Motor 1
f4 = (mass*g)/4; % Force for steady Level Flight about Motor 1
[t,z] = ode45('main',[0 5],condition);
plot3(z(:,1),z(:,2),-z(:,3),'-o')
title('Trajectory of Quad-Copter')
xlabel('N Displacement [m]')
ylabel('E Displacement [m]')
zlabel('-D Displacement [m]')

%% end