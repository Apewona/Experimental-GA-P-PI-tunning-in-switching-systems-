function ITSE = draw_chart(kp,ki,Emax,Emin)
%% DESCRIPTION
% Program simulating the operation of a buck converter circuit, consisting
% of a diode, MOSFET transistor, inductor, capacitor, and a proportional
% load represented by a resistor (a load model converting energy into heat).
% The system is described by discrete equations capturing the dynamics of
% this physical circuit, derived from Kirchhoff's laws for the circuit, as
% well as Faraday's law (for the inductor) and Gauss's law (for the capacitor).
% The differential equations are discretized in the time domain using the
% Euler method. The program does not utilize any functions to account for
% the nonlinearity of the diode voltage drop.

%% Defining the Time Step and Simulation Parameters
% The fundamental aspect to implement is the time step (deltaT), which
% represents the time interval for each simulation step. The accuracy of
% the simulation depends on the chosen deltaT. Next, the number of time
% steps to simulate needs to be defined. The product of the number of time
% steps (k) and deltaT determines the length of the simulation. However,
% it is recommended to define the number of time steps based on the user's
% desired simulation time (T) in seconds. By using deltaT and T, the
% numerical value for the number of time steps (k) can be determined.
%% Defining Circuit Constants
 deltaT = 1e-6;
 T = 2;

%% Defining Circuit Parameters
L = 10e-3;                          % [H]
C = 1000e-6;                        % [F]
R = 0.1;                            % [Ohm]
k = T/deltaT;                       % [-] - quantity of time steps
%% Define time vector 
t = linspace(0,T,k);

%% Defining the voltage drop across the diode and transistor
% In order for the program to run, the drop values ​​must be initialized
% voltage across the MOSFET and diode while these are conducting
% of items.
uT = 1;                               % [V]  - transistor voltage
sz = size(t);
x = size(t);
e = size(t);
%% Definiowanie wektorów wielkości występujących w układzie
% Ten etap polega na stworzeniu wektorów zmiennych, które będą opsywać
% wielkości występujące w symulacji przez cały okres jej trwania. 
% Circuit currents
iL = zeros(sz);                      % [A]   - inductor current
iO = zeros(sz);                      % [A]   - resistor current
% Circuit voltages
uC = zeros(sz);                      % [V]   - inductor voltage
uR = zeros(sz);                      % [V]   - resistor voltage
uz = 10;
%% Defining the transistor state (cyclic switching)
stan_tranzystora = 1; % Transistor is open [0] closed
%open_period = 10000; % transistor opening period in steps
tranzystor = zeros(sz); % vector collecting information about the MOSFET state
stan_e = zeros(sz);
stan_x = zeros(sz);
%% Main loop of the converter simulation program
% The entire simulation is performed in this part
for i=1:k
if x(i) > 0.2 
    stan_tranzystora = 1;
end
if x(i) < -0.2
    stan_tranzystora = -1;
end
  

%% Part of the main loop that calculates system size values
    if stan_tranzystora == 1
        E=Emax;
  % Equations describing the dynamics of the system when the transistor conducts,
  % result from the relationships presented in the study
    iL(i+1) = iL(i)+((deltaT*(1/L))*(E-uT-uC(i)));
    uC(i+1) = uC(i)+((deltaT*(1/C))*(iL(i)-((1/(R))*uC(i))));
    uR(i) = uC(i);
    iO(i) = (1/R)*uR(i);
    end
    if stan_tranzystora == -1
        E=Emin;
    iL(i+1) = iL(i)+((deltaT*(1/L))*(E-uT-uC(i)));
    uC(i+1) = uC(i)+((deltaT*(1/C))*(iL(i)-((1/(R))*uC(i))));
    uR(i) = uC(i);
    iO(i) = (1/R)*uR(i);
    end
    %% Part of the main loop responsible for the control system
 e(i+1) = uz - uC(i+1);
 stan_e(i) = e(i);
 %x(i+1) = kp*e(i+1);                                % P regulator
 x(i+1) =x(i)+ kp*(e(i+1)-e(i))+ki*e(i+1);           % PI regulator
 stan_x(i) = x(i);
 tranzystor(i) = stan_tranzystora;
end

%% Integral criteria calculations
AB = abs(stan_e);
ITSE = sum(AB)*deltaT;
%% Graphs of output quantities occurring in the system
f = figure();
f.Position = [0 50 500 500];
% Graph of the converter output current

subplot(3,1,1)
plot(t,iO); 
grid on;
title('Prąd Odbiornika');
ylabel('i_o(t) [A]')
xlabel('t [s]')

% Output voltage graph
subplot(3,1,2)
plot(t,uR);
grid on;
title('Napięcie Odbiornika');
ylabel('u_R(t) [V]')
xlabel('t [s]')

% Graph showing the state of the transistor
subplot(3,1,3)
plot(t,tranzystor*5);
grid on;
title('Sygnał Sterujący Źródłem');
ylabel('z(t) [V]')
xlabel('t [s]')
axis([0 T -11 11]);
end