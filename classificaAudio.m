% Autor: Denilson Gomes Vaz da Silva
% Departamento de Engenharia de Computação
% Processamento Digital de Sinais
% Script para classificar os audios (sim e nao)

%Carrega os audios
[n1,Fn1] = audioread('nao (1).wav');
[n2,Fn2] = audioread('nao (2).wav');
[n3,Fn3] = audioread('nao (3).wav');
[n4,Fn4] = audioread('nao (4).wav');
[n5,Fn5] = audioread('nao (5).wav');
[s1,Fs1] = audioread('sim (1).wav');
[s2,Fs2] = audioread('sim (2).wav');
[s3,Fs3] = audioread('sim (3).wav');
[s4,Fs4] = audioread('sim (4).wav');
[s5,Fs5] = audioread('sim (5).wav');

%pega a primeira coluna do audio
n1 = n1(:,1);
n2 = n2(:,1);
n3 = n3(:,1);
n4 = n4(:,1);
n5 = n5(:,1);

s1 = s1(:,1);
s2 = s2(:,1);
s3 = s3(:,1);
s4 = s4(:,1);
s5 = s5(:,1);

%Calcula as transformadas de Fourier dos audios
N1 = fftshift(fft(n1));
N2 = fftshift(fft(n2));
N3 = fftshift(fft(n3));
N4 = fftshift(fft(n4));
N5 = fftshift(fft(n5));

S1 = fftshift(fft(s1));
S2 = fftshift(fft(s2));
S3 = fftshift(fft(s3));
S4 = fftshift(fft(s4));
S5 = fftshift(fft(s5));

%Plota o modulo das TF dos audios
freq_vec = linspace(-pi,pi,length(N1));
figure,plot(freq_vec,abs(N1))
title('Transformada de Foutier do Nao') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

freq_vec = linspace(-pi,pi,length(S1));
figure,plot(freq_vec,abs(S1))
title('Transformada de Foutier do Sim') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

%Gera filtro
wc1 = 1; %Frquencia final
[B,A] = butter(20, wc1/pi, 'high');
[H,W] = freqz(B,A,length(y));
figure,plot(W,abs(H)) %Plota filtro Passa-alta
title('Transformada de Fourier do Filtro') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

%Filtar os sinais
%audio nao
n1f = filter(B,A,n1); %Sinal filtrado
%figure,plot(real(n1f)) %Plota o sinal filtrado
title('Sinal Filtrado no tempo') %Titulo
ylabel('Amplitude do Sinal Filtrado') %legenda
xlabel('Tempo discreto') %legenda

N1f = fftshift(fft(n1f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(N1f)); %Frequencias
figure,plot(freq_vec,abs(N1f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do Sinal Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

SNP = sum((abs(N1f)).^2)/length(N1f);

n2f = filter(B,A,n2); %Sinal filtrado
%figure,plot(real(n1f)) %Plota o sinal filtrado
title('Sinal Filtrado no tempo') %Titulo
ylabel('Amplitude do Sinal Filtrado') %legenda
xlabel('Tempo discreto') %legenda

N2f = fftshift(fft(n2f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(N2f)); %Frequencias
figure,plot(freq_vec,abs(N2f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do Sinal Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

SNP = SNP + sum((abs(N2f)).^2)/length(N2f);

MNP = SNP/2;

%audio sim
s1f = filter(B,A,s1); %Sinal filtrado
%figure,plot(real(n1f)) %Plota o sinal filtrado
title('Sinal Filtrado no tempo') %Titulo
ylabel('Amplitude do Sinal Filtrado') %legenda
xlabel('Tempo discreto') %legenda

S1f = fftshift(fft(s1f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(S1f)); %Frequencias
figure,plot(freq_vec,abs(S1f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do Sinal Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

SSP = sum((abs(S1f)).^2)/length(S1f);

s2f = filter(B,A,s2); %Sinal filtrado
%figure,plot(real(n1f)) %Plota o sinal filtrado
title('Sinal Filtrado no tempo') %Titulo
ylabel('Amplitude do Sinal Filtrado') %legenda
xlabel('Tempo discreto') %legenda

S2f = fftshift(fft(s2f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(S2f)); %Frequencias
figure,plot(freq_vec,abs(S2f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do Sinal Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

SSP = SSP + sum((abs(S2f)).^2)/length(S2f);

MSP = SSP/2;

%Testar os audios
[nt1,Fnt] = audioread('sim teste 4.wav');

nt1 = nt1(:,1);

nt1f = filter(B,A,nt1); %Sinal filtrado
%figure,plot(real(n1f)) %Plota o sinal filtrado
title('Sinal Filtrado no tempo') %Titulo
ylabel('Amplitude do Sinal Filtrado') %legenda
xlabel('Tempo discreto') %legenda

Nt1f = fftshift(fft(nt1f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(Nt1f)); %Frequencias
figure,plot(freq_vec,abs(Nt1f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do Sinal Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

MNT1 = sum(abs(Nt1f).^2)/length(Nt1f)

if MNT1 < 1
    disp('Não')
else
    disp('Sim')
end
