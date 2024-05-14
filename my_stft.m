function [S, f, t] = my_stft(signal, window, overlap, Nfft, Fs)
    %UNTITLED Summary of this function goes here
    signal_length = length(signal);
    window_length = length(window);

    step = floor(window_length * (1 - overlap));

    num_segments = floor((signal_length - window_length) / step) + 1;

    S = zeros(Nfft/2 + 1, num_segments);
    t = zeros(1, num_segments);

    for i = 1:num_segments
        start_index = (i - 1) * step + 1;
        end_index = start_index + window_length - 1;
        
        segment = signal(start_index:end_index);
        
        windowed_segment = segment .* window;
        
        Y = fft(windowed_segment, Nfft);
        
        P = abs(Y/Nfft);
        P = P(1:Nfft/2 + 1);
        P(2:end-1) = 2*P(2:end-1);
        
        S(:, i) = P;
        
        t(i) = start_index / Fs;
    end

    f = linspace(0, Fs/2, Nfft/2 + 1);
end
