clear; clc,close all; 
%% defines population sizes for GP
 N = 10;        % size of population
 il_pok = 1;   % generations quantity
%% define circuit extortion
 Emax = 30;     % maximum voltage of switching system
 Emin = 0;      % minimum voltage of switching system
 %% defines measure matrices

 [kppom,kipom,ITSEpom] = deal(zeros(il_pok,N));
 %[kpnaj,kinaj,ITSEnaj] = deal(zeros([il_pok 1]));
 %% initialize mate population
 kpmax = 100;
 kpmin = 0;
 ipmax = 1e-6;
 ipmin = 0;
 kmax = kpmax/2;
 kmin = kpmin/2;
 imax = ipmax/2;
 imin = ipmin/2;

 genotyp(:,1) = kmin + (kmax- kmin) * rand(N,1);
 genotyp(:,2) = kmin + (kmax - kmin) * rand(N,1);
 genotyp(:,3) = imin + (imax - imin)* rand(N,1);
 genotyp(:,4) = imin + (imax - imin)* rand(N,1);
 fenotyp = zeros(N,1);
 sor_genotyp = zeros([N 4]);
%% population grading 
ITSEnajlepsze = 1;
pokolenie = 0;
tic
while(pokolenie<il_pok)
    pokolenie = pokolenie+1;
disp(pokolenie)
for i=1:1:N
% Phenotypes getting
[kp,ki] = deal(genotyp(i,1)+genotyp(i,2),...
               genotyp(i,3)+genotyp(i,4));
ITSE = converter(kp,ki,Emax,Emin);
[kppom(pokolenie,i),kipom(pokolenie,i),ITSEpom(pokolenie,i)] = deal(kp,ki,ITSE);
fenotyp(i,1) = ITSE;
end

%% Selection
% ranking selection
sor_fenotyp = sort(fenotyp, 'ascend');
for a=1:1:N
    for j=1:1:N
        if sor_fenotyp(a) == fenotyp(j) 
            sor_genotyp(j,:) = genotyp(a,:);
        end
    end
end
[kpnaj(1,pokolenie),kinaj(1,pokolenie),ITSEnaj(1,pokolenie)] =...
                        deal(sor_genotyp(1,1)+sor_genotyp(1,2),...
                             sor_genotyp(1,3)+sor_genotyp(1,3),...
                             sor_fenotyp(1));
ITSEnajlepsze = ITSEnaj(1,pokolenie);
% crossing
populacja_potomkow = crossing(sor_genotyp,N);
% Mutations
genotyp_mut = mutate(populacja_potomkow,0.1);
genotyp = genotyp_mut;


end
toc

%% Choose best mate

% Ranking selection
sor_fenotyp = sort(fenotyp, 'ascend');
for i=1:1:N
    for j=1:1:N
        if sor_fenotyp(i) == fenotyp(j) 
            sor_genotyp(j,:) = genotyp(i,:);
        end
    end
end
[kp,ki] = deal(sor_genotyp(i,1)+sor_genotyp(i,2),...
               sor_genotyp(i,3)+sor_genotyp(i,4));
ITSE = draw_chart(kp,ki,Emax,Emin);
% Average values to draw average figure
for i = 1:1:il_pok
    avrgKp(1,i) = (sum(kppom(i,:))/N);
     avrgKi(1,i) = (sum(kipom(i,:))/N);
     avrgITSE(1,i) = (sum(ITSEpom(i,:))/N);
end
%% Wykresy
[XI, YI] = meshgrid(linspace(0, 0.2, 1000), linspace(0, 400, 1000));
ZI = griddata(kipom, kppom, ITSEpom, XI, YI);
f1 = figure();
plot3(kipom,kppom,ITSEpom,'x')
xlabel('k_i');
ylabel('k_p');
zlabel('AE');
grid on;


%%
f2 = figure();
plot(avrgKp,'LineStyle','--','Color','k');
hold on;
plot(kpnaj,'k');
grid on;
title('k_p (n)');
ylabel('k_p  [-]')
xlabel('n')
legend('average k_p','best k_p');

f3 = figure();
plot(avrgKi,'LineStyle','--','Color','k');
hold on;
plot(kinaj,'k');
grid on;
title('k_i (n)');
ylabel('k_i  [-]')
xlabel('n')
legend('average k_i','best k_i');

f4 = figure();
plot(avrgITSE,'LineStyle','--','Color','k');
hold on;
plot(ITSEnaj,'k');
grid on;
title('IAE (n)');
ylabel('IAE  [V]')
xlabel('n')
%xlim([1 15]);
legend('average AE','average AE');
%%
writematrix(ITSEpom,'ITSEpom.txt');