[x,Fs] = audioread('speech_19.wav'); % Reading in audio file #19

% Plot to find out which frequency to remove from signal

% Fourier Transform
nfft = 2^10; % FFT size
X = fft(x, nfft); % Compute FFT of the signal

% Frequency vector generation
fstep = Fs/nfft; % Frequency resolution
fvec = fstep*(0:nfft/2-1); % Frequency vector

% Amplitud spectrum calculation
fresp = 2*abs(X(1:nfft/2)); % Magnitude of the single-sided spectrum

% Deriving the maximum frequency 
[max_amp, idx] = max(fresp); % "idx" is the index of the max_amp
max_freq = fvec(idx); % "max_freq" is the freq corresponding to max_amp

% Display the max freq
fprintf('Highest amp = %.2f Hz.\n', max_freq);

% Notch filter design
Hd = notch_filter();
h = Hd.Numerator; % Getting filter coefficients
% Calculate the frequency response
[H, f] = freqz(h, 1, 1024, 16000);

% Apply filter to the signal
new_speech = filter(Hd, x);

X_filtered = fft(new_speech, nfft); % FFT of filtered signal
fresp_filtered = 2*abs(X_filtered(1:nfft/2)); % Magnitude of the filtered signal

% Plotting original vs filtered signal
%plot(fvec, fresp, 'b', 'LineWidth',1.5);
%hold on;
%plot(fvec, fresp_filtered, 'r--', 'LineWidth', 1.5);
%title('Original vs Filtered Signal Amplitud Spec')
%xlabel('Frequency (Hz)')
%ylabel(' |X(f)|')
%legend('Original Signal', 'Filtered Signal')
%hold off;

% Write the filtered signal to the .wav file
audiowrite('filtered_speech.wav', new_speech, Fs);

% UnderQuantizing the filter
q0 = quantizer('fixed', 'round', 'saturate', [30 29]);
h0 = quantize(q0, h);
% Calculate the frequency response
[H0, f0] = freqz(h0, 1, 1024, 16000);
Hd0 = dfilt.dffir(h0);
UnderQuantized = filter(Hd0, x);
audiowrite('UnderQuantized_filtered_speech.wav', UnderQuantized, Fs);

% Quantizing the filter
q1 = quantizer('fixed', 'round', 'saturate', [8 7]);
h1 = quantize(q1, h);
% Calculate the frequency response
[H1, f1] = freqz(h1, 1, 1024, 16000);
Hd1 = dfilt.dffir(h1);
Quantized = filter(Hd1, x);
audiowrite('Quantized_filtered_speech.wav', Quantized, Fs);


% OverQuantizing the filter
q2 = quantizer('fixed', 'round', 'saturate', [5 1]);
h2 = quantize(q2, h);
% Calculate the frequency response
[H2, f2] = freqz(h2, 1, 1024, 16000);
Hd2 = dfilt.dffir(h2);
OverQuantized = filter(Hd2, x);
audiowrite('OverQuantized_filtered_speech.wav', OverQuantized, Fs);

% Plotting filter vs quantized filter
plot(f/1000, 20*log10(abs(H)), 'b', 'lineWidth', 2); % Original filter
hold on;
plot(f0/1000, 20*log10(abs(H0)), 'y', 'lineWidth', 1); % UnderQuantized filter
hold on;
plot(f1/1000, 20*log10(abs(H1)), 'g', 'lineWidth', 1); % Quantized filter
hold on;
plot(f2/1000, 20*log10(abs(H2)), 'r', 'lineWidth', 1); % OverQuantized filter
xlim([0 8]);  % Limit x-axis from 0 to 8 kHz
ylim([-80 10]);  % Set y-axis limits to match the response seen in your image
title('Notch Filter Frequency Response: Original vs Quantized');
xlabel('Frequency (kHz)');
ylabel('Magnitude (dB)');
legend('Original filter', 'UnderQuantized Filter', 'Quantized Filter', 'OverQuantized Filter');
grid on;
hold off;


%Testing the quantizing of the filtered signal sound files
% Quantizing the filtered signal 
% (underquantized)
%q0 = quantizer('fixed','round', 'saturate',[7 6]);
%y0 = quantize(q0, new_speech);
%audiowrite('quantized_filter1.wav',y0, Fs);

% (quantized)
%q1 = quantizer('fixed','round', 'saturate',[13 12]);
%y1 = quantize(q1, new_speech);
%audiowrite('quantized_filter2.wav',y1, Fs);

% (overquantized)
%q2 = quantizer('fixed','round', 'saturate',[30 29]);
%y2 = quantize(q2, new_speech);
%audiowrite('quantized_filter3.wav',y2, Fs);

% Quantized filters FFT & Magnitud
% Underquantized
%X_underquantized = fft(y0, nfft); 
%fresp_underquantized = 2*abs(X_underquantized(1:nfft/2));

% Quantized
%X_quantized = fft(y1, nfft); 
%fresp_quantized = 2*abs(X_quantized(1:nfft/2));

% Overquantized
%X_overquantized = fft(y2, nfft); 
%fresp_overquantized = 2*abs(X_overquantized(1:nfft/2));

% Plot original filtered signal vs quantized variations
%plot(fvec, fresp_filtered, 'b', 'LineWidth',1.5);
%hold on;
%plot(fvec, fresp_underquantized, 'r--', 'LineWidth', 0.5);
%hold on;
%plot(fvec, fresp_quantized, 'g--', 'LineWidth', 0.5);
%hold on;
%plot(fvec, fresp_overquantized, 'y--', 'LineWidth', 0.5);
%title('Original filteres vs  Quantize Variations')
%xlabel('Frequency (Hz)')
%ylabel(' |X(f)|')
%legend('Filtered Signal', 'UnderQuantized filter', 'Quantized filter', 'OverQuantized filter')
%hold off;


function Hd = notch_filter
%NOTCH_FILTER Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 24.2 and DSP System Toolbox 24.2.
% Generated on: 09-Oct-2024 16:37:56

% Equiripple Bandstop filter designed using the FIRPM function.

% All frequency values are in Hz.
Fs = 16000;  % Sampling Frequency

Fpass1 = 5720;            % First Passband Frequency
Fstop1 = 5920;            % First Stopband Frequency
Fstop2 = 6095;            % Second Stopband Frequency
Fpass2 = 6295;            % Second Passband Frequency
Dpass1 = 0.028774368332;  % First Passband Ripple
Dstop  = 0.001;           % Stopband Attenuation
Dpass2 = 0.057501127785;  % Second Passband Ripple
dens   = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fpass1 Fstop1 Fstop2 Fpass2]/(Fs/2), [1 0 ...
                          1], [Dpass1 Dstop Dpass2]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd = dfilt.dffir(b);

% [EOF]
end
