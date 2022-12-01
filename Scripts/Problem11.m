%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Jack Lambert
% Aircraft Dynmaics Homework 2
% Problem 11
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

%% Varying Conditions for small pertubations Expirienced in None Homogenous Air
v_E_vec = randn(1,10)*.1; % Variation in the Inital Velocity of QuadCopter [m/s]
w_E_vec = randn(1,10)*.1; % Variation in the Inital Velocity of QuadCopter [m/s]
u_E_vec = rand(1,10)*.1; % Variation in the Inital Velocity of QuadCopter [m/s]
f1_vec = (randn(1,10).*.01+mass*g)*(1/4); % Varying the force from each motor
f2_vec = (randn(1,10).*.01+mass*g)*(1/4); % Varying the force from each motor
f3_vec = (randn(1,10).*.01+mass*g)*(1/4); % Varying the force from each motor
f4_vec = (randn(1,10).*.01+mass*g)*(1/4); % Varying the force from each motor
phi_vec = randn(1,10).*0.02; % Varying Inital Bank Angle
theta_vec = randn(1,10)*0.02; % Varying Inital Elevation Angle
psi_vec = randn(1,10)*0.02; % Varying Inital Azimuth Angle
for i = 1:10
    condition(1) = 0; % N - location [m]
    condition(2) = 0; % E - location [m]
    condition(3) = 0; % -D - location [m]
    condition(4) = u_E_vec(i); % u - component of velocity [m/s]
    condition(5) = v_E_vec(i); % v compenent of velocity [m/s]
    condition(6) = w_E_vec(i); % w component of velocity [m/s]
    % Rotational Motion
    condition(7) = phi_vec(i); % Phi Euler Angle [rad]
    condition(8) = theta_vec(i); % Theta Euler Angle [rad]
    condition(9) = psi_vec(i); % Psi Euler Angle [rad]
    condition(10) = 0; % Angular velocity about the x-axis [rad/s]
    condition(11) = 0; % Angular Velocity about the y-axis [rad/s]
    condition(12) = 0; % Angular Velocity about the z-axis [rad/s]
    f1 = f1_vec(i); % Force for steady Level Flight about Motor 1
    f2 = f2_vec(i); % Force for steady Level Flight about Motor 2
    f3 = f3_vec(i); % Force for steady Level Flight about Motor 3
    f4 = f4_vec(i); % Force for steady Level Flight about Motor 4
    figure(1)
    [t,z] = ode45('main',[0 3],condition);
    plot3(z(:,1),z(:,2),z(:,3))
    hold on
end

%% Plotting 
plot3(0,0,0,'-*')
title('Trajectory of Quad-Copter')
xlabel('N Displacement [m]')
ylabel('E Displacement [m]')
zlabel('-D Displacement [m]')
axis equal
hold off

%% end
