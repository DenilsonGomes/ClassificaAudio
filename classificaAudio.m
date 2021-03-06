% Autor: Denilson Gomes Vaz da Silva
% Departamento de Engenharia de Computa��o
% Processamento Digital de Sinais
% Script para classificar os audios (Sim e Nao)

clear
clc
close all

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

%Plota o modulo das TF dos audios (1 Sim e 1 Nao)
freq_vec = linspace(-pi,pi,length(N1));
figure,plot(freq_vec,abs(N1)) %Transformada de Fourier do Nao
title('Transformada de Foutier do Nao1') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

freq_vec = linspace(-pi,pi,length(S1));
figure,plot(freq_vec,abs(S1))% Plota TF do Sim
title('Transformada de Foutier do Sim1') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

%Gera filtro (de acordo com a visualiza��o dos audios na frequencia)
wc1 = 1; %Frquencia final
[B,A] = butter(20, wc1/pi, 'high'); %Filtro passa-alta
[H,W] = freqz(B,A,length(n1));
figure,plot(W,abs(H)) %Plota filtro Passa-alta
title('Transformada de Fourier do Filtro') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

%Filtar os sinais
%audio nao
n1f = filter(B,A,n1); %Sinal filtrado

N1f = fftshift(fft(n1f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(N1f)); %Frequencias
figure,plot(freq_vec,abs(N1f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do Nao1 Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

SNN = sum((abs(N1f)).^2)/length(N1f); %soma normalizada do Nao

n2f = filter(B,A,n2); %Sinal filtrado

N2f = fftshift(fft(n2f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(N2f)); %Frequencias
figure,plot(freq_vec,abs(N2f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do Nao2 Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

SNN = SNN + sum((abs(N2f)).^2)/length(N2f); %Soma normalizada do Nao

MNN = SNN/2; %Media normalizada do Nao

%audio sim
s1f = filter(B,A,s1); %Sim filtrado

S1f = fftshift(fft(s1f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(S1f)); %Frequencias
figure,plot(freq_vec,abs(S1f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do Sim1 Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

SNS = sum((abs(S1f)).^2)/length(S1f); %Soma normalizada do Sim

s2f = filter(B,A,s2); %Sinal filtrado

S2f = fftshift(fft(s2f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(S2f)); %Frequencias
figure,plot(freq_vec,abs(S2f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do Sim2 Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

SNS = SNS + sum((abs(S2f)).^2)/length(S2f); %Soma normalizada do Sim

MNS = SNS/2; %Media normalizada do Sim

%Testar os audios
acertos = 0;
%Audio Nao 1
[nt,Fnt] = audioread('nao teste 1.wav');

nt = nt(:,1);

nt1f = filter(B,A,nt); %Sinal filtrado

Nt1f = fftshift(fft(nt1f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(Nt1f)); %Frequencias
figure,plot(freq_vec,abs(Nt1f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do nao teste 1 Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

MNT = sum(abs(Nt1f).^2)/length(Nt1f) %Media normalizada (do modulo da TF) do teste 

if MNT < 1
    disp('N�o')
    acertos = acertos + 1;
end

%Audio Nao 2
[nt,Fnt] = audioread('nao teste 2.wav');

nt = nt(:,1);

nt1f = filter(B,A,nt); %Sinal filtrado

Nt1f = fftshift(fft(nt1f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(Nt1f)); %Frequencias
figure,plot(freq_vec,abs(Nt1f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do nao teste 2 Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

MNT = sum(abs(Nt1f).^2)/length(Nt1f) %Media normalizada (do modulo da TF) do teste 

if MNT < 1
    disp('N�o')
    acertos = acertos + 1;
end

%Audio Nao 3
[nt,Fnt] = audioread('nao teste 3.wav');

nt = nt(:,1);

nt1f = filter(B,A,nt); %Sinal filtrado

Nt1f = fftshift(fft(nt1f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(Nt1f)); %Frequencias
figure,plot(freq_vec,abs(Nt1f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do nao teste 3 Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

MNT = sum(abs(Nt1f).^2)/length(Nt1f) %Media normalizada (do modulo da TF) do teste 

if MNT < 1
    disp('N�o')
    acertos = acertos + 1;
end

%Audio Sim 1
[nt,Fnt] = audioread('sim teste 1.wav');

nt = nt(:,1);

nt1f = filter(B,A,nt); %Sinal filtrado

Nt1f = fftshift(fft(nt1f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(Nt1f)); %Frequencias
figure,plot(freq_vec,abs(Nt1f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do sim teste 1 Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

MNT = sum(abs(Nt1f).^2)/length(Nt1f) %Media normalizada (do modulo da TF) do teste 

if MNT > 1
    disp('Sim')
    acertos = acertos + 1;
end

%Audio Sim 2
[nt,Fnt] = audioread('sim teste 2.wav');

nt = nt(:,1);

nt1f = filter(B,A,nt); %Sinal filtrado

Nt1f = fftshift(fft(nt1f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(Nt1f)); %Frequencias
figure,plot(freq_vec,abs(Nt1f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do sim teste 2 Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

MNT = sum(abs(Nt1f).^2)/length(Nt1f) %Media normalizada (do modulo da TF) do teste 

if MNT > 1
    disp('Sim')
    acertos = acertos + 1;
end

%Audio Sim 3
[nt,Fnt] = audioread('sim teste 3.wav');

nt = nt(:,1);

nt1f = filter(B,A,nt); %Sinal filtrado

Nt1f = fftshift(fft(nt1f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(Nt1f)); %Frequencias
figure,plot(freq_vec,abs(Nt1f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do sim teste 3 Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

MNT = sum(abs(Nt1f).^2)/length(Nt1f) %Media normalizada (do modulo da TF) do teste 

if MNT > 1
    disp('Sim')
    acertos = acertos + 1;
end

%Audio Sim 4
[nt,Fnt] = audioread('sim teste 4.wav');

nt = nt(:,1);

nt1f = filter(B,A,nt); %Sinal filtrado

Nt1f = fftshift(fft(nt1f)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(Nt1f)); %Frequencias
figure,plot(freq_vec,abs(Nt1f)) %Plota TF do sinal filtrado
title('Transformada de Foutier do sim teste 4 Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

MNT = sum(abs(Nt1f).^2)/length(Nt1f) %Media normalizada (do modulo da TF) do teste 

if MNT > 1
    disp('Sim')
    acertos = acertos + 1;
end

str = ['Percentual de acerto obtido: ', num2str(acertos*100/7)];
disp(str); %exibe a mensagem acima com o valor

% Observando os modulos da Transformada de Fourier de cada audio podemos notar
% que o audio "sim teste 4" � bem proximo do audio "nao teste 1", por isso este 
% audio "sim teste 4" nao foi classificado com exito