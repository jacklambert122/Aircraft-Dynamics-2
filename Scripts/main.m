function [dydt] = main(t,y)

%% Global Variables
global mass g R k eta zeta alpha beta Ix Iy Iz f1 f2 f3 f4 

%% Derivatives to be Integrated

% Translational Motion
dx = y(1); % N - location
dy = y(2); % E - location
dz = y(3); % -D - location
Vx = y(4); % u - component of velocity
Vy = y(5); % v compenent of velocity
Vz = y(6); % w component of velocity

% Rotational Motion
phi = y(7); % Attitude Euler Angles
theta = y(8); % Attitude Euler Angles
psi = y(9); % Attitude Euler Angles
p = y(10); % Angular velocity about the x-axis [rad/s]
q = y(11); % Angular Velocity about the y-axis [rad/s]
r = y(12); % Angular Velocity about the z-axis [rad/s]

%% Velocity
mag = sqrt(Vx^2+Vy^2+Vz^2); % Magnitude of velocity rel to body 
% Redefining for context
u = Vx;
v = Vy;
w = Vz;

%% Forces to Acceleration

% Aerodynimc Forces
A_c = [0 0 -(f1+f2+f3+f4)]; % Control Forces
A_a = [-eta*u^2*sign(u) -eta*v^2*sign(v) -zeta*w^2*sign(w)]; % Aerodynamics Forces
A_b = A_c + A_a; % Combined Forces

% Kinematic Equations
dydt(1) = u*cos(theta)*cos(psi)+ v*(sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi))...
    + w*(cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi)); 
dydt(2) = u*cos(theta)*sin(psi)+ v*(sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi))...
    + w*(cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi));
dydt(3) = -u*sin(theta)+v*sin(phi)*cos(theta)+w*cos(phi)*cos(theta);
dydt(4) = (A_b(1)-mass*g*sin(theta))/mass;
dydt(5) = (A_b(2)+mass*g*cos(theta)*sin(phi))/mass;
dydt(6) = (A_b(3)+mass*g*cos(theta)*cos(phi))/mass;

%% Moments to Rotations
G_a = [-alpha*p^2 -alpha*q^2 -beta*r^2];
G_c = [R*(f2+f3-f1-f4) R*(f3+f4-f2-f1) k*(f2+f4-f1-f2)];
G_b = G_a + G_c;

% Kinemeatic Equations
dydt(7) = p + (q*sin(phi)+r*cos(phi))*tan(theta);
dydt(8) = q*cos(phi)-r*sin(phi);
dydt(9) = (q*sin(phi)+r*cos(phi))*sec(theta);
dydt(10) = (G_b(1)+q*r*(Iy - Iz))/Ix;
dydt(11) = (G_b(2)+r*p*(Iz-Ix))/Iy;
dydt(12) = (G_b(3)+p*q*(Ix-Iy))/Iz;

dydt = dydt';
