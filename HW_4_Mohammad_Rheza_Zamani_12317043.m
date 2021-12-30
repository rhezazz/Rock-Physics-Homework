%PR 4  Fisika Batuan
%Mohammad Rheza Zamani
%12317043
clc;
clear all;
%Fluid properties
brine_density = 1100;
gas_density = 100;
oil_density = 800;
K_brine = 2.6*10^9;
K_gas = 0.02*10^9;
K_oil = 1.15*10^9;
%Rock properties
kuarsa_density = 2650;
K_kuarsa = 37*10^9;
myu_kuarsa = 44*10^9;
%Input data dari excel
depth = xlsread('HW_4_5_2020.xlsx',1,'A195:A248');
Vp = xlsread('HW_4_5_2020.xlsx',1,'C195:C248')*1000;
Vs = xlsread('HW_4_5_2020.xlsx',1,'D195:D248')*1000;
rho = xlsread('HW_4_5_2020.xlsx',1,'E195:E248')*1000;
%Hitung myu batuan 
for i = 1 : length(Vp)
    myu_batuan(i) = rho(i)*Vs(i).^2;
end
myu_batuan2 = myu_batuan';
%Hitung K batuan 
 for i = 1 : length(myu_batuan2)
     K_batuan(i) = rho(i)*Vp(i).^2 - (4/3).*myu_batuan2(i);
 end
 K_batuan2 = K_batuan';
 %Porosity
 for i = 1 : length(rho)
     p1(i) = (kuarsa_density - rho(i))./(kuarsa_density - brine_density );
 end
 p2 = p1';
 %K brine
 K_brine1 = zeros(length(K_batuan2));
 for i = 1 : length(K_batuan2)
     K_brine2(i) = K_brine1(i) + K_brine;
 end
 K_brine3 = K_brine2';
 %K oil
  K_oil1 = zeros(length(K_batuan2));
 for i = 1 : length(K_batuan2)
     K_oil2(i) = K_oil1(i) + K_oil;
 end
 K_oil3 = K_oil2';
 %K gas
 K_gas1 = zeros(length(K_batuan2));
 for i = 1 : length(K_batuan2)
     K_gas2(i) = K_gas1(i) + K_gas;
 end
 K_gas3 = K_gas2';
 %K kuarsa
  K_kuarsa1 = zeros(length(K_batuan2));
 for i = 1 : length(K_batuan2)
     K_kuarsa2(i) = K_kuarsa1(i) + K_kuarsa;
 end
 K_kuarsa3 = K_kuarsa2';
 %Menghitung K saturated brine
 for i = 1 : length(K_batuan)
     K_saturated_brine(i) = K_batuan(i)+((K_kuarsa2(i)*(1-(K_batuan(i)./K_kuarsa2(i))).^2)./(1.-p2(i)-(K_batuan(i)./K_kuarsa2(i))+(p2(i).*(K_kuarsa2(i)/K_brine2(i)))));
 end
 K_saturated_brine1 = K_saturated_brine';
 %Menghitung rho saturated brine
 for i = 1 : length(rho)
     rho_saturated_brine(i) = rho(i) + p2(i).*brine_density;
 end
 rho_saturated_brine1 = rho_saturated_brine';
 %menghitung Vp saturated brine
 for i = 1 : length(K_saturated_brine1)
     Vp_saturated_brine(i) = sqrt((K_saturated_brine1(i)+(4/3)*myu_batuan(i))/rho_saturated_brine1(i));
 end
  Vp_saturated_brine1 =  Vp_saturated_brine';
 %Menghitung Vs saturated brine
 for i = 1 : length(K_saturated_brine1)
     Vs_saturated_brine(i) = sqrt(myu_batuan(i)/rho_saturated_brine1(i));
 end
  Vs_saturated_brine1 =  Vs_saturated_brine';
%Subsitusi dengan oil
%K saturated oil
for i = 1 : length(p2)
    K_saturated_oil(i) = (((K_oil3(i)/(p2(i)*(K_kuarsa3(i)-K_oil3(i))))+(K_saturated_brine1(i)/(K_kuarsa3(i)-K_saturated_brine1(i)))-(K_brine3(i)/(p2(i)*(K_kuarsa3(i)-K_brine3(i)))))./(1+((K_oil3(i)/(p2(i)*(K_kuarsa3(i)-K_oil3(i))))+(K_saturated_brine1(i)/(K_kuarsa3(i)-K_saturated_brine1(i)))-(K_brine3(i)/(p2(i)*(K_kuarsa3(i)-K_brine3(i))))))).*(K_kuarsa3(i));
end
K_saturated_oil1 = K_saturated_oil';
%rho saturated oil
rho_oil1 = zeros(length(rho));
for i = 1 : length(rho)
    rho_oil2(i) = rho_oil1(i) + oil_density;
end
rho_oil3 = rho_oil2';
for i = 1 : length(rho)
    rho_saturated_oil(i) = rho(i) + rho_oil3(i)*p2(i);
end
rho_saturated_oil1 = rho_saturated_oil';
%Vp saturated oil
for i = 1 : length(K_saturated_oil1)
    Vp_saturated_oil(i) = sqrt((K_saturated_oil1(i)+(4/3)*myu_batuan2(i))./rho_saturated_oil1(i));
end
Vp_saturated_oil1 = Vp_saturated_oil';
%Vs saturated oil
for i = 1 : length(myu_batuan2)
    Vs_saturated_oil(i) = sqrt(myu_batuan2(i)./rho_saturated_oil1(i));
end
%Subsitusi dengan gas
%K saturated gas
for i = 1 : length(p2)
    K_saturated_gas(i) = (((K_gas3(i)/(p2(i)*(K_kuarsa3(i)-K_gas3(i))))+(K_saturated_brine1(i)/(K_kuarsa3(i)-K_saturated_brine1(i)))-(K_brine3(i)/(p2(i)*(K_kuarsa3(i)-K_brine3(i)))))./(1+((K_gas3(i)/(p2(i)*(K_kuarsa3(i)-K_gas3(i))))+(K_saturated_brine1(i)/(K_kuarsa3(i)-K_saturated_brine1(i)))-(K_brine3(i)/(p2(i)*(K_kuarsa3(i)-K_brine3(i))))))).*(K_kuarsa3(i));
end
K_saturated_gas1 = K_saturated_gas';
%rho saturated gas
rho_gas1 = zeros(length(rho));
for i = 1 : length(rho)
    rho_gas2(i) = rho_gas1(i) + gas_density;
end
rho_gas3 = rho_gas2';
for i = 1 : length(rho)
    rho_saturated_gas(i) = rho(i) + rho_gas3(i)*p2(i);
end
rho_saturated_gas1 = rho_saturated_gas';
%Vp saturated gas
for i = 1 : length(K_saturated_gas1)
    Vp_saturated_gas(i) = sqrt((K_saturated_gas1(i)+(4/3)*myu_batuan2(i))./rho_saturated_gas1(i));
end
Vp_saturated_gas1 = Vp_saturated_gas';
%Vs saturated gas
for i = 1 : length(myu_batuan2)
    Vs_saturated_gas(i) = sqrt(myu_batuan2(i)./rho_saturated_gas1(i));
end
Vs_saturated_gas1 = Vs_saturated_gas';

%Plot 
figure(1)
%Plot Log Vp
subplot(1,3,1)
hold on
title('Log Vp')
plot(Vp_saturated_brine1,depth,'r')
plot(Vp_saturated_oil1,depth,'b')
plot(Vp_saturated_gas1,depth,'g')
legend({'brine','oil','gas'},'location','northeast')
legend('boxoff')
xlabel('Vp(m/s)')
ylabel('Depth(m)')
set (gca (), 'ydir', 'reverse')
grid on
hold off
%Plot Log Vs
subplot(1,3,2)
hold on
title('Log Vs')
plot(Vs_saturated_brine1,depth,'r')
plot(Vs_saturated_oil,depth,'b')
plot(Vs_saturated_gas1,depth,'g')
legend({'brine','oil','gas'},'location','northeast')
legend('boxoff')
xlabel('Vs(m/s)')
ylabel('Depth(m)')
set (gca (), 'ydir', 'reverse')
grid on
hold off
%Plot Log rho
subplot(1,3,3)
hold on
title('Log rho')
plot(rho_saturated_brine1,depth,'r')
plot(rho_saturated_oil1,depth,'b')
plot(rho_saturated_gas1,depth,'g')
legend({'brine','oil','gas'},'location','southwest')
legend('boxoff')
xlabel('Rho(Kg/m^3)')
ylabel('Depth(m)')
set (gca (), 'ydir', 'reverse')
grid on
hold off

saveas(figure(1),'HW 4.jpg')
writematrix(p2,'poro.txt','delimiter', 'tab')
writematrix(myu_batuan2,'myu rock.txt','delimiter', 'tab')
writematrix(K_batuan2,'K rock.txt','delimiter', 'tab')
writematrix(K_saturated_brine1,'K brine saturated.txt','delimiter', 'tab')