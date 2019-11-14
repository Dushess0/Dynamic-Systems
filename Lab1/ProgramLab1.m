% Zadanie 1. Zaleznośc stanu systemu od parametrow R i C

close all
% ustawienie zmiennych globalnych wykorzystywanych w trakcie symulacji
FinalVoltage = 0;
InitialVoltage = 0;
StepTime = 0; % czas po ktorym odbedzie sie skok na skokowym zrodle napiecia
SimulationTime = 10;
% plik z glowna symulacja 
open('SimLinkLab1');
figure('Renderer', 'painters', 'Position', [0 0 900 800])
set_param('SimLinkLab1/switch', 'sw', '1');
% Layout utworzony z dwoch klatek : 
% 1 - wykres przy parametrach domyslnych
% 2 - wykres dla zmienionych parametrow
% Rysowanie wykresu dla parametrow podanych w konspekcie
%-------------------------------------------%
% deklaracja wektorow
Rv = [10,5,15];
Cv = [0.1,0.05,0.15];
WPCv = [4,6,8];
%-------------------------------------------%
tiledlayout(2,1);
nexttile


%Gorny wykres
K = 1/(R * Cv(1));
a = sim('SimLinkLab1');
plot(a.tout,a.u);
hold on;
leg1 = legend('u(t)');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',17);
xlabel('Czas');
ylabel('Sterowanie');
grid
title('Stan systemu dla parametrow podanych w konspekcie')
nexttile

% Inicjalizacja roznych wartosci R, C, WPC 
R = Rv(1);
WPC=WPCv(1);
% Wizualizacja napiecia na kondesatorze dla roznych pojemnosci 

for i = 1:3
    
    K = 1/(R * Cv(i));
    a = sim('SimLinkLab1');
    plot(a.tout,a.x);
    hold on;
end
grid
xlabel('Czas');
ylabel('Napiecie na kondensatorze');
leg1 = legend('$C = 0.10 F\;R = 10\,\Omega\; x_0 = 4V$','$C=0.05F\; R = 10\,\Omega\; x_0= 4V$','$C = 0.15F\; R = 10\,\Omega\; x_0 = 4 V$');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',17);
title('Stan systemu dla roznej pojemnosci');
hold off 
fprintf('Widac, ze im wieksa pojemnosc kondesatora, tym szybciej on sie rozladowywuje\n')
fprintf('Dowolny klawisz zeby kontynuowac ... \n')
pause

% Zaleznosc stanu systemu od oporu rezystora
clf;
nexttile;
plot(a.tout,a.u);
title('Stan systemu dla parametrow podanych w konspekcie')
leg1 = legend('Sterowanie u(t)=0');
xlabel('Czas');
ylabel('Sterowanie');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',17);
grid;
nexttile;

%reset
WPC = WPCv(1);
C = Cv(1);
%wykresy dla roznych oporow
for i = 1:3  
    K = 1/(Rv(i) * C);
    a = sim('SimLinkLab1');
    plot(a.tout,a.x);
    hold on;
end
grid
leg1 = legend('$C = 0.10 F\;R = 10\,\Omega\; x_0 = 4V$','$C=0.10F\; R = 5\,\Omega\; x_0= 4V$','$C = 0.10F\; R = 15\,\Omega\; x_0 = 4 V$');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',17);
title('Stan systemu dla roznej opornosci')
xlabel('Czas');
ylabel('Napiecie na kondensatorze');

hold off
fprintf('Im wiekszy jest opor rezystora tym wolniej on sie rozladowywuje\n')
fprintf('Dowolny klawisz zeby kontynuowac\n')
pause

% Zaleznosc stanu systemu od WPC
clf
nexttile
plot(a.tout,a.u);
title('Stan systemu dla parametrow podanych w konspekcie')
leg1 = legend('Sterowanie u(t)=0');
xlabel('Czas');
ylabel('Sterowanie');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',17);
grid
nexttile
R = Rv(1);
C = Cv(1);
K = 1 /(R * C);
for i = 1:3  
    WPC = WPCv(i);
    a = sim('SimLinkLab1');
    plot(a.tout,a.x);
    hold on;
end
grid
title('Stan systemu dla roznego stanu poczetkowego')
leg1 = legend('$C = 0.10 F\;R = 10\,\Omega\; x_0 = 4V$','$C=0.10F\; R = 10\,\Omega\; x_0= 6V$','$C = 0.10F\; R = 10\,\Omega\; x_0 = 8 V$');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',17);
xlabel('Czas');
ylabel('Napiecie na kondensatorze');

hold off
fprintf('Niezaleznie od poczatkowego napiecia na kondensatorze rozladowywanie zawsze nastepuje w tym samym momencie czasu\n');
fprintf('Czas rozladowywania zalezy tylko od pojemnosci i oporu\n');
fprintf('Dowolny klawisz zeby kontynuowac\n');
pause




% Zadanie 2. Analiza ukladu dla WPC = 0 i roznych wartosci stalego
% sterowania
clf
WPC = 0;
values = 1:4;
colors = ['r','g','b','c'];
for i = 1:4
InitialVoltage = values(i);
FinalVoltage = values(i);
a = sim('SimLinkLab1');
xlabel('Czas');
ylabel('Napiecie na kondensatorze');
plot(a.tout,a.x,colors(i));
hold on
plot(a.tout,a.u, colors(i));
hold on
end
fprintf('Napiecie na kondensatorze nie moze byc wyzsze od napiecia sterowania\n');

grid;
hold off;
pause;

% Zadanie 3. Analiza zachowania ukladu dla stalego stereowania rownego 1 i
% roznych wartosci poczatkowych

clf;
InitialVoltage = 1;
FinalVoltage = 1;
values = linspace(5,20,4);
for i = 1:4
WPC = values(i);
a = sim('SimLinkLab1');
plot(a.tout,a.x);
xlabel('Czas');
ylabel('Napiecie na kondensatorze');
hold on
end
grid
title('Rozne wartosci wpc');
fprintf('Mozna zauwazyc ze niezaleznie od poczatkowego napiecia na kondensatorze czas jego rozladowania pozostaje taki sam\n');
fprintf('I napiecie na kondensatorze nie moze byc ponizej 1, poniewaz sterowanie=1\n');

hold off
pause

% Zadanie 4. Analiza dla roznych wartosci R i C, przy skoku nappiecia po 5
% sekunzie
clf;

StepTime = 5;
SimulationTime=10;
InitialVoltage = 3;
FinalVoltage = 0;
WPC = 0;
tiledlayout(2,1);
nexttile
%rozpatrywane wartosci oporu
Rv = [10,15];
%rozpatrywane wartosci pojemnosci
Cv = [0.1,0.15];

%gorny wykres
K = 1/ (Rv(1) * Cv(1));
a = sim('SimLinkLab1');
plot(a.tout,a.x);
grid
hold on
size(a.tout)
size(a.x);
plot(a.tout,a.u);


%dolny wykres
nexttile
K = 1/ (Rv(2) * Cv(2));
a = sim('SimLinkLab1');
plot(a.tout,a.x);
hold on
plot(a.tout,a.u);
grid
fprintf('');
hold off

pause

% Zadanie 5. Podanie sygnalu o ksztalcie synusoidy
clf
Rv = linspace(10,40,4);
Cv = linspace(0.1,1,4);
RC = Rv .* Cv;
SimulationTime = 10;
for i= 1:4
K = 1/RC(i);
set_param('SimLinkLab1/switch','sw','0');
a = sim('SimLinkLab1');
plot(a.tout,a.x);
hold on 
end
pause

% Zadanie 6. Przykladowe rozwiazanie zadan z kolokwium 

% Zadanie 1.4
R = 10^6;
C = 10^(-6);
WPC = -1.72;

