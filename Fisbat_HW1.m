%PR fisika batuan nomor 1
%Nama : Mohammad Rheza Zamani
%NIM : 12317043
clear all;
clc;
rho_h = 0.65; %Nilai rho hidrokarbon
rho_brine = 1.01; %Nilai rho air asin
rho_grain = 2.65; %Nilai rho grain
Sw = xlsread('Fisbat.xlsx',2,'G4:G404'); %Membaca data Sw dari Excel
for i = 1: (length(Sw)) %Perulangan untuk menghitung rho fluida
    rho_fluida(i) = rho_brine*Sw(i) + rho_h*(1-Sw(i));
end
r = rho_fluida';
rho = xlsread('Fisbat.xlsx',2,'D4:D404'); %Membaca data densitas dari Excel
rho_grain1= zeros(length(rho));
for i =1:length(rho) %Perulangan untuk membuat matriks rho grain
    rho_grain2(i) = rho_grain1(i) + 2.65;
end
rho_grain = rho_grain2';
for i =1 : (length(rho)) %Perulangan untuk mendapat nilai porositas
    poro(i) = (rho_grain(i)-rho(i))/(rho_grain(i)- r(i));
end
p = poro';
Depth = xlsread('Fisbat.xlsx',2,'A4:A404');%Membaca data depth dari excel
GR = xlsread('Fisbat.xlsx',2,'B4:B404'); %Membaca data Gamma Ray dari excel
Vp = xlsread('Fisbat.xlsx',2,'F4:F404'); %Membaca data kecapatan gelombang P dari excel

writematrix(p,'Porositas PR no 1 Fisika Batuan.txt')%Export data ke dalam text file
%Plot depth vs GR , depth vs Vp, depth vs density, depth vs porosity
figure(1)
subplot(1,4,1)
plot(GR,Depth,'b');
set (gca (), 'ydir', 'reverse')
title('Depth vs GR');
xlabel('GR');
ylabel('depth (feet)');
grid on;

subplot(1,4,2)
plot(Vp,Depth,'r');
set (gca (), 'ydir', 'reverse')
title('Depth vs Vp');
xlabel('Vp (m/s)')
ylabel('depth (feet)');
grid on;

subplot(1,4,3)
plot(rho,Depth,'m');
set (gca (), 'ydir', 'reverse')
title('Depth vs rho');
xlabel('density (gr/cc)')
ylabel('depth (feet)');
grid on;

subplot(1,4,4)
plot(p,Depth,'g');
set (gca (), 'ydir', 'reverse')
title('Depth vs porosity');
xlabel('porosity (%)')
ylabel('depth (feet)');
grid on;

saveas(figure(1),'HW1.jpeg')%Menyimpan gambar plot dalam format jpeg

