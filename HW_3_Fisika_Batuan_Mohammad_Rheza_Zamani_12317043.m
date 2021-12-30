%Tugas 3 Fisika Batuan
%Mohammad Rheza Zamani
%12317043
clc;
clear all;
%Diketahui
K_kuarsa = 37*10^9; %Satuan Pascal
K_brine = 2.6*10^9; %Satuan Pascal
K_oil = 1.1*10^9;%Satuan Pascal
myu_kuarsa = 44*10^9; %Satuan Pascal
rho_brine = 1070; %Satuan kg/m^3
rho_oil = 700; %Satuan kg/m^3
%Membaca Porositas sampel 1 dan 2 dari excel
p1 = xlsread('HW_1_2_3_2020.xlsx',3,'C11:C16');
p2 = xlsread('HW_1_2_3_2020.xlsx',3,'C17:C22');
%Membaca data P,rho dry, Vp dry, dan Vs dry sample 1 dari excel
P1 = xlsread('HW_1_2_3_2020.xlsx',3,'B11:B16');
rho_dry1 =xlsread('HW_1_2_3_2020.xlsx',3,'D11:D16')*1000;
Vp_dry1 = xlsread('HW_1_2_3_2020.xlsx',3,'E11:E16')*1000;
Vs_dry1 = xlsread('HW_1_2_3_2020.xlsx',3,'F11:F16')*1000;
%Membaca data P, rho dry, Vp dry, dan Vs dry sample 2 dari excel
P2 = xlsread('HW_1_2_3_2020.xlsx',3,'B17:B22');
rho_dry2 =xlsread('HW_1_2_3_2020.xlsx',3,'D17:D22')*1000;
Vp_dry2 = xlsread('HW_1_2_3_2020.xlsx',3,'E17:E22')*1000;
Vs_dry2 = xlsread('HW_1_2_3_2020.xlsx',3,'F17:F22')*1000;

%Menghitung myu dry 1
for i = 1 : length(rho_dry1)
    myu_dry1(i) = rho_dry1(i).*(Vs_dry1(i)).^2;
end
%Menghitung myu dry 2
for i = 1 : length(rho_dry2)
    myu_dry2(i) = rho_dry2(i).*(Vs_dry2(i)).^2;
end
%Hitung K dry 1
for i = 1 : length(rho_dry1)
    K_dry1(i) = (rho_dry1(i).*Vp_dry1(i).^2) - (4/3).*myu_dry1(i);
end
%Hitung K dry 2
for i = 1 : length(rho_dry2)
    K_dry2(i) = (rho_dry2(i).*Vp_dry2(i).^2) - (4/3).*myu_dry2(i);
end

%Brine Saturated sampel 1
%Menghitung K brine saturasisampel 1
for i = 1 : length(K_dry1)
    K_sat1_brine(i) = K_dry1(i)+((K_kuarsa.*(1.-(K_dry1(i)./K_kuarsa)).^2)./(1.-p1(i)-(K_dry1(i)./K_kuarsa)+(p1(i).*(K_kuarsa/K_brine))));
end
%Menghitung rho brine saturasi sampel 1
for i = 1 : length(rho_dry1)
    rho_sat_brine1(i) = rho_dry1(i) + p1(i).*rho_brine;
end
%Menghitung Vp brine saturasi sampel 1
for i = 1 : length(K_sat1_brine)
    Vp_sat_brine1(i) = sqrt((K_sat1_brine(i)+(4/3)*myu_dry1(i))./rho_sat_brine1(i));
end
%Menghitung Vs brine saturasi sampel 1
for i = 1 : length(rho_sat_brine1)
    Vs_sat_brine1(i) = sqrt(myu_dry1(i)./rho_sat_brine1(i));
end
%Oil Saturated sampel 1
%Menghitung K oil saturasisampel 1
for i = 1 : length(K_dry1)
    K_sat1_oil(i) = K_dry1(i)+((K_kuarsa.*(1.-(K_dry1(i)./K_kuarsa)).^2)./(1.-p1(i)-(K_dry1(i)./K_kuarsa)+(p1(i).*(K_kuarsa/K_oil))));
end
%Menghitung rho oil saturasi sampel 1
for i = 1 : length(rho_dry1)
    rho_sat_oil1(i) = rho_dry1(i) + p1(i).*rho_oil
end
%Menghitung Vp oil saturasi sampel 1
for i = 1 : length(K_sat1_oil)
    Vp_sat_oil1(i) = sqrt((K_sat1_oil(i)+(4/3).*myu_dry1(i))./rho_sat_oil1(i));
end
%Menghitung Vs oil saturasi sampel 1
for i = 1 : length(rho_sat_brine1)
    Vs_sat_oil1(i) = sqrt(myu_dry1(i)./rho_sat_oil1(i));
end
%Brine Saturated sampel 2
%Menghitung K brine saturasisampel 2
for i = 1 : length(K_dry2)
    K_sat2_brine(i) = K_dry2(i)+((K_kuarsa.*(1.-(K_dry2(i)./K_kuarsa)).^2)./(1.-p2(i)-(K_dry2(i)./K_kuarsa)+(p1(i).*(K_kuarsa/K_brine))));
end
%Menghitung rho brine saturasi sampel 2
for i = 1 : length(rho_dry2)
    rho_sat_brine2(i) = rho_dry2(i) + p2(i).*rho_brine;
end
%Menghitung Vp brine saturasi sampel 2
for i = 1 : length(K_sat2_brine)
    Vp_sat_brine2(i) = sqrt((K_sat2_brine(i)+(4/3)*myu_dry2(i))./rho_sat_brine2(i));
end
%Menghitung Vs brine saturasi sampel 2
for i = 1 : length(rho_sat_brine2)
    Vs_sat_brine2(i) = sqrt(myu_dry2(i)./rho_sat_brine2(i));
end
%Oil Saturated sampel 2
for i = 1 : length(K_dry2)
    K_sat2_oil(i) = K_dry2(i)+((K_kuarsa.*(1.-(K_dry2(i)./K_kuarsa)).^2)./(1.-p2(i)-(K_dry2(i)./K_kuarsa)+(p2(i).*(K_kuarsa/K_oil))));
end
%Menghitung rho oil saturasi  sampel 2
for i = 1 : length(rho_dry1)
    rho_sat_oil2(i) = rho_dry2(i) + p2(i).*rho_oil;
end
%Menghitung Vp oil saturasi sampel 2
for i = 1 : length(K_sat2_oil)
    Vp_sat_oil2(i) = sqrt((K_sat2_oil(i)+(4/3).*myu_dry2(i))./rho_sat_oil2(i));
end
%Menghitung Vs oil saturasi sampel 2
for i = 1 : length(rho_sat_brine2)
    Vs_sat_oil2(i) = sqrt(myu_dry2(i)./rho_sat_oil2(i));
end

%Plot grafik
%Crossplot Vp dry,sat brine,sat oil sampel 1 
figure(1)
hold on
plot(P1,Vp_dry1,'r');
plot(P1,Vp_sat_brine1,'b');
plot(P1, Vp_sat_oil1,'g');
xlabel('Pressure (MPa)');
ylabel('Vp (m/s)');
title('Crossplot P vs Vp sampel 1')
legend({'P vs Vp dry', 'P vs Vp saturasi brine', 'P vs Vp saturasi oil'},'location','northwest')
legend('boxoff')
grid on
hold off

%Crossplot Vs dry,sat brine, sat oil sampel 1
figure(2)
hold on
plot(P1,Vs_dry1,'r');
plot(P1,Vs_sat_brine1,'b');
plot(P1, Vs_sat_oil1,'g');
xlabel('Pressure (MPa)');
ylabel('Vs (m/s)');
title('Crossplot P vs Vs sampel 1')
legend({'P vs Vs dry', 'P vs Vs saturasi brine', 'P vs Vs saturasi oil'},'location','northwest')
legend('boxoff')
grid on
hold off

%Crossplot K dry,sat brine, sat oil sampel 1
figure(3)
hold on
plot(P1,K_dry1./10^9,'r');
plot(P1,K_sat1_brine./10^9,'b');
plot(P1, K_sat1_oil./10^9,'g');
xlabel('Pressure (MPa)');
ylabel('K (GPa)');
title('Crossplot P vs K sampel 1')
legend({'P vs K dry', 'P vs K saturasi brine', 'P vs K saturasi oil'},'location','northwest')
legend('boxoff')
grid on
hold off

%Crossplot Vp dry,sat brine,sat oil sampel 2 
figure(4)
hold on
plot(P2,Vp_dry2,'r');
plot(P2,Vp_sat_brine2,'b');
plot(P2, Vp_sat_oil2,'g');
xlabel('Pressure (MPa)');
ylabel('Vp (m/s)');
title('Crossplot P vs Vp sampel 2')
legend({'P vs Vp dry', 'P vs Vp saturasi brine', 'P vs Vp saturasi oil'},'location','northwest')
legend('boxoff')
grid on
hold off

%Crossplot Vs dry,sat brine, sat oil sampel 2
figure(5)
hold on
plot(P2,Vs_dry2,'r');
plot(P2,Vs_sat_brine2,'b');
plot(P2, Vs_sat_oil2,'g');
xlabel('Pressure (MPa)');
ylabel('Vs (m/s)');
title('Crossplot P vs Vs sampel 2')
legend({'P vs Vs dry', 'P vs Vs saturasi brine', 'P vs Vs saturasi oil'},'location','northwest')
legend('boxoff')
grid on
hold off

%Crossplot K dry,sat brine, sat oil sampel 2
figure(6)
hold on
plot(P2,K_dry2./10^9,'r');
plot(P2,K_sat2_brine./10^9,'b');
plot(P2, K_sat2_oil./10^9,'g');
xlabel('Pressure (MPa)');
ylabel('K (GPa)');
title('Crossplot P vs K sampel 2')
legend({'P vs K dry', 'P vs K saturasi brine', 'P vs K saturasi oil'},'location','northwest')
legend('boxoff')
grid on
hold off
%Menyimpan gambar plot dalam format jpeg
saveas(figure(1),'Crossplot P vs Vp sampel 1.jpg')
saveas(figure(2),'Crossplot P vs Vs sampel 1.jpg')
saveas(figure(3),'Crossplot P vs K sampel 1.jpg')
saveas(figure(4),'Crossplot P vs Vp sampel 2.jpg')
saveas(figure(5),'Crossplot P vs Vs sampel 2.jpg')
saveas(figure(6),'Crossplot P vs K sampel 2.jpg')