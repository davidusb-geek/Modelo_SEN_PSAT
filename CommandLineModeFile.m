% m-file for power flow computation using PSAT in command line mode
clear all
clc

% Preamble:
% Definir los "paths" de PSAT y de cualquier otro toolbox a utilizar

addpath(genpath('C:\Users\davidusb\Documents\MATLAB')) % La carpeta con todos los toolbox utilizados
% DEBE MODIFICARSE LA DIRECCION DE LA CARPETA (PATH) EN CUALQUIER OTRA PC

closepsat % Se cierra cualquier sesión PSAT abierta anteriormente

% Initialize
initpsat
% clpsat.readfile = 0;

% Loading file
runpsat('v2012_PF.mdl','data')

% Running power flow
runpsat('pf')
Settings.init;

if Settings.init > 0
    disp('Power Flow converged')
else
    disp('Power Flow NOT. converged')
end

% Generate PF report
runpsat('pfrep')

% Bus voltages and angles
Vbus = DAE.y(Bus.v);
Vangle = DAE.y(Bus.a);
long = length(Vbus);
nombres = Bus.names; % Nombres de las barras en vector "nombres"

% Line flows
[P_s,Q_s,P_r,Q_r,fr_bus,to_bus] = fm_flows('bus');

% Computing line losses:
nseries = Settings.nseries;
iline = [1:nseries]';
MVA  = 1; % Cambiar si se quieren mostrar los resultados en MVA
line_ffr = [iline, fr_bus, to_bus, P_s*MVA, Q_s*MVA]; % Desde la linea...
line_fto = [iline, to_bus, fr_bus, P_r*MVA, Q_r*MVA]; % Hacia la linea...
line_p_losses = line_ffr(:,4) + line_fto(:,4); % Vector de pérdidas

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%RESULTS (NOTA: Solo valido para archivo v2012_PF_Andes115kV.mdl)
% Voltajes en 765 kV:
Vbus_vector = [Vbus(73);%Guri
    Vbus(98); %Malena
    Vbus(134); %San Geronimo
    Vbus(145); %Sur OMZ
    Vbus(87); %La Horqueta
    Vbus(80); %La Arenosa
    Vbus(163); %Yaracuy
    ];
Vbus_names = [Bus.names(73);%Guri
    Bus.names(98); %Malena
    Bus.names(134); %San Geronimo
    Bus.names(145); %Sur OMZ
    Bus.names(87); %La Horqueta
    Bus.names(80); %La Arenosa
    Bus.names(163); %Yaracuy
    ];
Vbus_angles = [Vangle(73);%Guri
    Vangle(98); %Malena
    Vangle(134); %San Geronimo
    Vangle(145); %Sur OMZ
    Vangle(87); %La Horqueta
    Vangle(80); %La Arenosa
    Vangle(163); %Yaracuy
    ];

[m,n] = size(Vbus_vector); 
vmax = 0.95*ones(1,m); vmin = 1.05*ones(1,m);% Voltage limits
figure, plot(Vbus_vector,'bo-','LineWidth',2), hold on, plot(Vbus_angles,'rs-','LineWidth',2)
plot(vmax,'k--','LineWidth',2), plot(vmin,'k--','LineWidth',2)
ylabel('Modulo (pu) y Angulo (rad) de tension') %,'interpreter','latex'
set(gca,'YGrid','on','YTick',[-0.6:0.1:1.2],'Box','off')
set(get(gca,'xlabel'), 'Rotation',90) 
xticks([1:7]);
xticklabels(Vbus_names);
xtickangle(45);
legend('Modulo (pu)','Angulo (rad)','V_{max} 105%','V_{min} 95%') %,'interpreter','latex'

% Voltajes en 230 y 115 kV region Los Andes:
Vbus_vector = [Vbus(161);
    Vbus(3);
    Vbus(2);
    Vbus(153);
    Vbus(45);
    Vbus(1);
    Vbus(64);
    Vbus(5);
    Vbus(93);
    Vbus(92);
    Vbus(141);
    Vbus(114);
    Vbus(100);
    Vbus(9);
    Vbus(10);
    Vbus(11);
    Vbus(13);
    Vbus(12);
    Vbus(142);
    Vbus(52);
    Vbus(88);
    Vbus(105);
    Vbus(104);
    Vbus(135);
    Vbus(97);
    Vbus(123);
    Vbus(140);
    Vbus(159);
    Vbus(158);
    Vbus(152);
    Vbus(103);
    Vbus(27);
    Vbus(17);
    Vbus(16);
    Vbus(20);
    Vbus(119);
    Vbus(118);
    Vbus(55);
    Vbus(54);
    Vbus(128);
    Vbus(149);
    Vbus(40);
    Vbus(101);
    Vbus(102);
    Vbus(106);
    Vbus(84);
    Vbus(53);
    Vbus(83);
    Vbus(127);
    Vbus(120);
    Vbus(43);
    Vbus(42);
    Vbus(129);
    Vbus(130);
    Vbus(112);
    Vbus(82);
    Vbus(136);
    Vbus(126);
    Vbus(160);
    Vbus(156);
    Vbus(155);
    Vbus(143);
    Vbus(89);
    Vbus(67);
    Vbus(56);
    ];
Vbus_names = [Bus.names(161);
    Bus.names(3);
    Bus.names(2);
    Bus.names(153);
    Bus.names(45);
    Bus.names(1);
    Bus.names(64);
    Bus.names(5);
    Bus.names(93);
    Bus.names(92);
    Bus.names(141);
    Bus.names(114);
    Bus.names(100);
    Bus.names(9);
    Bus.names(10);
    Bus.names(11);
    Bus.names(13);
    Bus.names(12);
    Bus.names(142);
    Bus.names(52);
    Bus.names(88);
    Bus.names(105);
    Bus.names(104);
    Bus.names(135);
    Bus.names(97);
    Bus.names(123);
    Bus.names(140);
    Bus.names(159);
    Bus.names(158);
    Bus.names(152);
    Bus.names(103);
    Bus.names(27);
    Bus.names(17);
    Bus.names(16);
    Bus.names(20);
    Bus.names(119);
    Bus.names(118);
    Bus.names(55);
    Bus.names(54);
    Bus.names(128);
    Bus.names(149);
    Bus.names(40);
    Bus.names(101);
    Bus.names(102);
    Bus.names(106);
    Bus.names(84);
    Bus.names(53);
    Bus.names(83);
    Bus.names(127);
    Bus.names(120);
    Bus.names(43);
    Bus.names(42);
    Bus.names(129);
    Bus.names(130);
    Bus.names(112);
    Bus.names(82);
    Bus.names(136);
    Bus.names(126);
    Bus.names(160);
    Bus.names(156);
    Bus.names(155);
    Bus.names(143);
    Bus.names(89);
    Bus.names(67);
    Bus.names(56);
    ];
Vbus_angles = [Vangle(161);
    Vangle(3);
    Vangle(2);
    Vangle(153);
    Vangle(45);
    Vangle(1);
    Vangle(64);
    Vangle(5);
    Vangle(93);
    Vangle(92);
    Vangle(141);
    Vangle(114);
    Vangle(100);
    Vangle(9);
    Vangle(10);
    Vangle(11);
    Vangle(13);
    Vangle(12);
    Vangle(142);
    Vangle(52);
    Vangle(88);
    Vangle(105);
    Vangle(104);
    Vangle(135);
    Vangle(97);
    Vangle(123);
    Vangle(140);
    Vangle(159);
    Vangle(158);
    Vangle(152);
    Vangle(103);
    Vangle(27);
    Vangle(17);
    Vangle(16);
    Vangle(20);
    Vangle(119);
    Vangle(118);
    Vangle(55);
    Vangle(54);
    Vangle(128);
    Vangle(149);
    Vangle(40);
    Vangle(101);
    Vangle(102);
    Vangle(106);
    Vangle(84);
    Vangle(53);
    Vangle(83);
    Vangle(127);
    Vangle(120);
    Vangle(43);
    Vangle(42);
    Vangle(129);
    Vangle(130);
    Vangle(112);
    Vangle(82);
    Vangle(136);
    Vangle(126);
    Vangle(160);
    Vangle(156);
    Vangle(155);
    Vangle(143);
    Vangle(89);
    Vangle(67);
    Vangle(56);
    ];

% Vbus_vector = Vbus;
% Vbus_names = Bus.names;
% Vbus_angles = Vangle;

[m,n] = size(Vbus_vector); 
vmax = 0.95*ones(1,m); vmin = 1.05*ones(1,m);% Voltage limits
figure 
set(gcf, 'Units', 'centimeter');
set(gcf, 'Position', [10 10 20 10], 'PaperPosition', [30 30 20 10]);
movegui('center')
plot(Vbus_vector,'bo-','LineWidth',2), hold on, plot(Vbus_angles,'rs-','LineWidth',2)
plot(vmax,'k--','LineWidth',2), plot(vmin,'k--','LineWidth',2)
ylabel('Modulo (pu) y Angulo (rad) de tension') %,'interpreter','latex'
set(gca,'YGrid','on','YTick',[-1:0.1:1.2],'Box','off','XLim',[0 66],'YLim',[-1 1.2])

ax = gca; % Get current axes
ax.XAxis.FontSize = 8;
xticks([1:65]);
xticklabels(Vbus_names);
xtickangle(90);
legend('Modulo (pu)','Angulo (rad)','V_{max} 105%','V_{min} 95%','Location','SouthWest','Orientation','horizontal') %,'interpreter','latex'


% Se pueden calcular las perdidas en las lineas:
% Potencia transmitida en linea en Guri-Malena:
% Potencia=-P_s(156)*3;
% Perdida en Guri-Malena:
% Perdida = line_p_losses(156)*3;
% PerdidaTOT = sum(line_p_losses); % Perdidas totales en todas las lineas del sistema
