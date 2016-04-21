function displacement = deriveDisp(accelerometer_data,ts)
% accelerometer_data - evenly spaced data extracted from accelerometer
% ts - the sampling period
N1 = length(accelerometer_data);
N = 2^nextpow2(N1);
  if N > N1
      accelerometer_data(N1+1:N) = 0; % pad array with 0's
  end
  fs = 1 / (N*ts); % differential frequency element
  Nyq = 1 / (2*ts); % Nyquist sampling frequency
  acc_freq_data = fftshift(fft(accelerometer_data));%performes dtft on acceleration data
  disp_freq_data = zeros(size(acc_freq_data));%where the displacement data will be stored
  f = -Nyq:fs:Nyq-fs; % I think this is how fftshift organizes it
  for i = 1 : N
      if f(i) ~= 0
          disp_freq_data(i) = acc_freq_data(i)/(2*pi*f(i)*sqrt(-1))^2;%recall that alpha = -w^2*r
      else
          disp_freq_data(i) = 0;
      end
  end
  displacement = ifft(ifftshift(disp_freq_data)); %takes the displacement data out of frequency domain  
  displacement = displacement(1:N1);%removes zero padding
return  


