clear all
close all;
A = fopen('FlashmemApr9.txt', 'r');
a = fscanf(A, '%x %x %x');
a = a';
t = 0:1/100:(length(a)/12/100)-(1/100);
j = 1;
neg = false;
%% Handling z-Acceleration data
for i = 1:12:length(a)
    MSB = dec2hex(a(i+1));
    LSB = dec2hex(a(i));
    if strcmp(MSB, 'FF') == true
        neg = true;
        MSB = '00';
    end
    y=strcat(MSB, LSB);
    y = hex2dec(y);
    if neg == true
        y = -y;
    end
    y = y/1024;
    zAccel(j) = y/9.8;
    neg = false;
%     zAccel(j) = zAccel(j)/9.8;
    j = j+1;
%     j = j+1;
end
%% Handling y-acceleration data
j = 1;
for i = 3:12:length(a)
    MSB = dec2hex(a(i+1));
    LSB = dec2hex(a(i));
    if strcmp(MSB, 'FF') == true
        neg = true;
        MSB = '00';
    end
    y=strcat(MSB, LSB);
    y = hex2dec(y);
    if neg == true
        y = -y;
    end
    y = y/1024;
    yAccel(j) = y/9.8;
    neg = false;
%     zAccel(j) = zAccel(j)/9.8;
    j = j+1;
%     j = j+1;
end

%% Handling x-Acceleration
j=1;
for i = 5:12:length(a)
    MSB = dec2hex(a(i+1));
    LSB = dec2hex(a(i));
    if strcmp(MSB, 'FF') == true
        neg = true;
        MSB = '00';
    end
    y=strcat(MSB, LSB);
    y = hex2dec(y);
    if neg == true
        y = -y;
    end
    y = y/1024;
    xAccel(j) = y/9.8;
    neg = false;
%     zAccel(j) = zAccel(j)/9.8;
    j = j+1;
%     j = j+1;
end
%% Handling the z-Angle
j=1;
for i = 7:12:length(a)
    MSB = dec2hex(a(i+1));
    LSB = dec2hex(a(i));
    if strcmp(MSB, 'FF') == true
        neg = true;
        MSB = '00';
    end
    y=strcat(MSB, LSB);
    y = hex2dec(y);
    if neg == true
        y = -y;
    end
    y = y/16.4;
    zAngle(j) = y;
    neg = false;
%     zAccel(j) = zAccel(j)/9.8;
    j = j+1;
%     j = j+1;
end

%% Handling the y-angle
j=1;
for i = 9:12:length(a)
    MSB = dec2hex(a(i+1));
    LSB = dec2hex(a(i));
    if strcmp(MSB, 'FF') == true
        neg = true;
        MSB = '00';
    end
    y=strcat(MSB, LSB);
    y = hex2dec(y);
    if neg == true
        y = -y;
    end
    y = y/16.4;
    yAngle(j) = y;
    neg = false;
%     zAccel(j) = zAccel(j)/9.8;
    j = j+1;
%     j = j+1;
end

%% Handling x-angle
j=1;
for i = 11:12:length(a)-1
    MSB = dec2hex(a(i+1));
    LSB = dec2hex(a(i));
    if strcmp(MSB, 'FF') == true
        neg = true;
        MSB = '00';
    end
    y=strcat(MSB, LSB);
    y = hex2dec(y);
    if neg == true
        y = -y;
    end
    y = y/16.4;
    xAngle(j) = y;
    neg = false;
%     zAccel(j) = zAccel(j)/9.8;
    j = j+1;
%     j = j+1;
end

zAccel = cascadingFilter(zAccel, 3, 40);
yAccel = cascadingFilter(yAccel, 3, 40);
xAccel = cascadingFilter(xAccel, 3, 40);
zAngle = cascadingFilter(zAngle, 3, 40);
yAngle = cascadingFilter(yAngle, 3, 40);
xAngle = cascadingFilter(xAngle, 3, 40);

%z-acceleration
figure;plot(t(1:length(zAccel)), zAccel);
xlabel('Time(s)');
ylabel('Acceleration (m/s^2)');
title('Z-Acceleration');

%z-displacement
zdisp = deriveDisp(zAccel, 1/100);
figure;plot(t(1:length(zAccel)), zdisp);
xlabel('Time(s)');
ylabel('Position (m)');
title('Z-Displacement');

%y-acceleration
figure;plot(t(1:length(yAccel)), yAccel);
xlabel('Time(s)');
ylabel('Acceleration (m/s^2)');
title('Y-Acceleration');

%y-displacement
ydisp = deriveDisp(yAccel, 1/100);
figure;plot(t(1:length(yAccel)), ydisp);
xlabel('Time(s)');
ylabel('Position (m)');
title('Y-Displacement');

%x-acceleration
figure;plot(t(1:length(xAccel)), xAccel);
xlabel('Time(s)');
ylabel('Acceleration (m/s^2)');
title('X-Acceleration');

%x-displacement
xdisp = deriveDisp(xAccel, 1/100);
figure;plot(t(1:length(xAccel)), zdisp);
xlabel('Time(s)');
ylabel('Position (m)');
title('X-Displacement');

%z-angle
figure;plot(t(1:length(zAngle)), zAngle);
xlabel('Time(s)');
ylabel('Angular Velocity(\omega)');
title('Z-Angular Velocity');

%y-angle
figure;plot(t(1:length(yAngle)), yAngle);
xlabel('Time(s)');
ylabel('Anglular Velocity(\omega)');
title('Y-Angular Velocity');

%x-angle
figure;plot(t(1:length(xAngle)), xAngle);
xlabel('Time(s)');
ylabel('Angular Velocity(\omega)');
title('X-Angular Velocity');
