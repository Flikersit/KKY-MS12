%% load data and parameters
clc;
clear all;
close all;
data = load('C:\Users\User\Desktop\signal.mat');
frequency = 80000;
%% vizualization of a signal
duration = length(data.signal)/frequency;
time = linspace(0, duration ,length(data.signal));
plot(time, data.signal)
grid on;
xlabel('time(s)')
ylabel('value')
title('signal')
%% time parameters
average_value = mean(data.signal);
disp(['Avarage value of a signal: ', num2str(average_value)]);
energy = sum(data.signal.^2);
disp(['Energy of a signal: ', num2str(energy)]);
effective_value = sqrt(mean(data.signal.^2));
disp(['Effective value:', num2str(effective_value)]);
%% frekvencni parametry
N = length(data.signal);
Y = fft(data.signal); 

% Create frequency vektor
Fs = 80000;
f = Fs*(0:(N/2))/N;

% Create spektrum of capacity
P = abs(Y/N);
P = P(1:N/2+1);
P(2:end-1) = 2*P(2:end-1);

% Graph
plot(f, P)
grid on;
title('Spectr')
xlabel('frequency (Hz)')
ylabel('Amplitude')
%% princip neurcitosti
windowLengths = [256, 4096];
for i = 1:length(windowLengths)
    window = hamming(windowLengths(i)); 
    noverlap = round(0.9 * windowLengths(i));
    nfft = max(256, 2^nextpow2(windowLengths(i)));

   
    [S, F, T] = my_stft(data.signal, window, noverlap, nfft, frequency);

    
    figure;
    spectrogram(data.signal, window, noverlap, nfft, frequency, 'yaxis');
    title(['Spectrogram with window length ', num2str(windowLengths(i))]);
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    colorbar;
end




