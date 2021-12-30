%PR fisika batuan nomor 2a
%Nama : Mohammad Rheza Zamani
%NIM : 12317043
clear all;
clc;
%cut off GR 50
GR = xlsread('Fisbat.xlsx',1,'B2:B1288'); %GR Seluruh
depth = xlsread('Fisbat.xlsx',1,'A2:A1288'); %Kedalaman seluruh
Vp1 = xlsread('Fisbat.xlsx',3,'C2:C967'); %Vp Shale
Vp2 = xlsread('Fisbat.xlsx',4,'C2:C322'); %Vp Sandstone
Vs1 = xlsread('Fisbat.xlsx',3,'D2:D967'); %Vs Shale
Vs2 = xlsread('Fisbat.xlsx',4,'D2:D322'); %Vs Sandstone
Vratio1 = Vp1./Vs1; %ratio Vp/Vs shale
Vratio2 = Vp2./Vs2;%ratio Vp/Vs sandstone
rho_kuarsa11 = zeros(length(Vp1),1);
rho_brine11 = zeros(length(Vp1),1);
for i = 1:length(rho_kuarsa11)
    for j = 1:length(rho_brine11)
        rho_kuarsa1(i) = rho_kuarsa11(i) + 2.64;
        rho_brine1(j) = rho_brine11(j) + 1.08;
    end
end
rho_kuarsa22 = zeros(length(Vp2),1);
rho_brine22 = zeros(length(Vp2),1);
for i = 1:length(rho_kuarsa22)
    for j = 1:length(rho_brine22)
        rho_kuarsa2(i) = rho_kuarsa22(i) + 2.64;
        rho_brine2(j) = rho_brine22(j) + 1.08;
    end
end
rho_bulk1 = xlsread('Fisbat.xlsx',3,'E2:E967');%rho bulk shale
rho_bulk2 = xlsread('Fisbat.xlsx',4,'E2:E322');%rho bulk sandstone
for i = 1:length(rho_bulk1)
    poro1(i) = ((rho_kuarsa1(i) - rho_bulk1(i))/ (rho_kuarsa1(i) - rho_brine1(i)));
end
for i = 1:length(rho_bulk2)
    poro2(i) = ((rho_kuarsa2(i) - rho_bulk2(i))/ (rho_kuarsa2(i) - rho_brine2(i)));
end
p1 = poro1'; %Porossitas Shale
p2 = poro2'; %Porositas Sandstone

figure(1)
subplot(1,2,1)
plot(GR,depth,'r')
xlabel('GR (API)')
ylabel('depth (m)')
title('GR vs depth')
xline(50,'b')%Cut off reservoir
legend('Respon Log GR' , 'cut off')
grid on

subplot(1,2,2)
hold on
sz1 = 10;
sz2 = 10;
scatter(p1,Vratio1,sz1,'b')
scatter(p2,Vratio2,sz2,'r')
title('Porosity vs Vp/Vs');
xlabel('Porosity(%)');
ylabel('Vp/Vs');
grid on
legend('Shale', 'Sandstone')
hold off

saveas(figure(1),'HW 2a.jpeg')%Menyimpan gambar plot dalam format jpeg