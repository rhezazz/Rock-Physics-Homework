%PR fisika batuan nomor 2c
%Nama : Mohammad Rheza Zamani
%NIM : 12317043
clc;
clear all;
Vp = xlsread('Fisbat.xlsx',4,'C2:C322');
Vs = xlsread('Fisbat.xlsx',4,'D2:D322');
rho_kuarsa1 = zeros(length(Vp),1);
rho_brine1 = zeros(length(Vp),1);
for i = 1:length(rho_kuarsa1)
    for j = 1:length(rho_brine1)
        rho_kuarsa(i) = rho_kuarsa1(i) + 2.64;
        rho_brine(j) = rho_brine1(j) + 1.08;
    end
end
rho_bulk = xlsread('Fisbat.xlsx',4,'E2:E322');
for k = 1:length(rho_bulk)
    poro(k) = ((rho_kuarsa(k) - rho_bulk(k))./ (rho_kuarsa(k) - rho_brine(k)));
end
p = poro';
%Menghitung Vp pada kuarsa dan brine
Kt_kuarsa = 37; %K teoritis kuarsa satuan GPa
Kt_brine = 2.6; %K teoritis brine satuan GPa
myu_kuarsa = 44; %myu teoritis kuarsa satuan Gpa
myu_brine = 0; %myu teoritis brine satuan Gpa
for l = 1 : length(Vp)
    Vp_kuarsa(l) = sqrt((Kt_kuarsa +(4/3)*myu_kuarsa)/(rho_kuarsa(l))).*10^3;
end
Vpk = Vp_kuarsa';
for m = 1 : length(Vp)
    Vp_brine(m) = sqrt((Kt_brine +(4/3)*myu_brine)/(rho_brine(m))).*10^3;
end
Vpb = Vp_brine';
%fraksi volume
f1 = zeros(length(Vp),1);
for n = 1: length(Vp)
    f(n) = n*(1/(length(Vp)));
end
F = f';
%Pemodelan Voight dan Reuss
for r = 1 : (length(F)) % model Voight 
    Vv1(r) = Vpk(r).*(1-F(r)) + Vpb(r).*(F(r));
end
for s = 1 : (length(F)) %Model Reuss
    Vr1(s) =1./((Vpk(s)).*(1-F(s)) + (Vpb(s)).*(F(s))); 
end
V_hill = (Vr1'+Vv1')/2;
%Plot
hold on
sz=5;
plot(F,Vv1,'r')
plot(F,Vr1,'b')
plot(F,V_hill,'c')
scatter(p,Vp,sz,'g');
title('Porosity vs Vp');
xlabel('Porosity (%)');
ylabel('Vp (m/s)');
legend('Voight', 'Reuss', 'Hill', 'Data terukur')
grid on;
hold off

saveas(figure(1),'HW 2c.jpeg')%Menyimpan gambar plot dalam format jpeg