%PR fisika batuan nomor 2b
%Nama : Mohammad Rheza Zamani
%NIM : 12317043
clc;
clear all;
%K dan Myu pengukuran
%Membaca data kecepatan dan rho bulk dari excel
Vp = xlsread('Fisbat.xlsx',1,'C2:C1288');
Vs = xlsread('Fisbat.xlsx',1,'D2:D1288');
rho_bulk= xlsread('Fisbat.xlsx',1,'E2:E1288')*1000;
%mengitung K dan Myu densitas bulk
for i = 1:length(Vp)
    K(i) = (rho_bulk(i)).*((Vp(i).^2) - ((4/3).*(Vs(i).^2)));
end
for j = 1:length(Vs)
    myu1 (j) = Vs(j).^2 .* rho_bulk(j);
end
k = K';
myu = myu1';
%membuat matriks rho kuarsa dan brine
rho_kuarsa1 = zeros(length(Vp),1);
rho_brine1 = zeros(length(Vp),1);
for i = 1:length(rho_kuarsa1)
    for j = 1:length(rho_brine1)
        rho_kuarsa(i) = rho_kuarsa1(i) + 2640;
        rho_brine(j) = rho_brine1(j) + 1080;
    end
end
for i = 1:length(rho_bulk)
    poro(i) = ((rho_kuarsa(i) - rho_bulk(i))/ (rho_kuarsa(i) - rho_brine(i)));
end
p = poro';
%fraksi volume
f1 = zeros(length(Vp),1);
for i = 1: length(Vp)
    f(i) = (i)*(1/(length(Vp)));
end
F = [0 ; f']; 
Kt_kuarsa = 37*10^9; %K teoritis kuarsa satuan Pa
Kt_brine = 2.6*10^9; %K teoritis brine satuan Pa
myu_kuarsa = 44*10^9; %myu teoritis kuarsa satuan Gpa
myu_brine = 0*10^9; %myu teoritis brine satuan Gpa
%Pemodelan Voight, Reus, voigth-reuss-hill, Hashin-Shrikman untuk K
for i = 1 : (length(F)) % model Voight 
    kv1(i) = (Kt_kuarsa.*(1-F(i)) + Kt_brine.*(F(i)));
end
for j = 1 : (length(F)) %Model Reuss
     kr1(j) =1./((Kt_kuarsa).*(1-F(j)) + (Kt_brine).*(F(j)));
end
 for n = 1: (length(F))%Hashin-Shtrikman upper bound
     h1(n) = (Kt_kuarsa + ((F(n))/((1/(Kt_brine-Kt_kuarsa))+(1-F(n))*(1/(Kt_kuarsa+((4*myu_kuarsa)/3))))));
 end
 for m = 1: (length(F))%Hashin-Shtrikman lower bound
     h12(m) = (Kt_brine + ((1-F(m))/((1/(Kt_kuarsa-Kt_brine))+(F(m))*(1/(Kt_brine+((4*myu_brine)/3))))));
 end
 v1 = (kr1' + kv1')./2; % Model Voight-Reuss-Hill
 %Pemodelan Voight, Reus, voigth-reuss-hill, Hashin-Shrikman untuk myu
for r = 1 : (length(F)) % model Voight 
    kv2(r) = myu_kuarsa.*(1-F(r)) + myu_brine.*(F(r));
end
for s = 1 : (length(F)) %Model Reuss
     kr2(s) =1./((myu_kuarsa).*(1-F(s)) + (myu_brine).*(F(s)));
end
 for t = 1: (length(F))%Hashin-Shtrikman upper bound
     h2(t) = myu_kuarsa +(F(t)/((myu_brine-myu_kuarsa)^-1+2*(1-F(t))*(Kt_kuarsa+2*myu_kuarsa)*(5*myu_kuarsa*(Kt_kuarsa+(4/3)*myu_kuarsa))^-1));
 end
 for u = 1: (length(F))%Hashin-Shtrikman lower bound
     h22(u) = myu_brine +((1-F(u))/((myu_kuarsa-myu_brine)^-1+2*(F(u))*(Kt_brine+2*myu_brine)*(5*myu_brine*(Kt_brine+(4/3)*myu_brine))^-1));
 end
v2 = (kr2' + kv2')/2; % Model Voight-Reuss-Hill
 
%Plot Plot Porosity vs K serta model Voightm Reuss, Hill, & Hashin-Shtrikman
subplot(2,1,1)
hold on
sz =3;
plot(F,kv1,'r')
plot(F,kr1,'k')
plot(F,v1,'c')
plot(F,h1,'y')
plot(F,h12,'g')
scatter(p,k,sz,'m')
xlabel('Porosity (%)')
ylabel('K (Pa)')
title('Porosity (%) vs K (Pa)')
legend({'Voight', 'Reuss', 'Hill', 'Hashin-Shthrikman Upper', 'Hashin-Shthrikman Lower', 'Data pengukuran'},'Location','northeast')
grid on
hold off
%Plot Porosity vs myu serta model Voightm Reuss, Hill, & HashinShtrikman
subplot(2,1,2)
hold on
plot(F,kv2,'r')
plot(F,kr2,'k')
plot(F,v2,'c')
plot(F,h2,'y')
plot(F,h22,'g')
scatter(p,myu,sz,'m')
xlabel('Porosity (%)')
ylabel('myu (Pa)')
title('Porosity (%) vs myu (Pa)')
legend({'Voight', 'Reuss', 'Hill', 'Hashin-Shthrikman Upper', 'Hashin-Shthrikman Lower', 'Data pengukuran'},'Location','northeast')
grid on
hold off

saveas(figure(1),'HW 2b.jpeg')%Menyimpan gambar plot dalam format jpeg


