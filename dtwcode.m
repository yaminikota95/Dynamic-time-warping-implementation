clc; close all; 
%select the audios to allign
file1 = '194102309_o_2.wav';
file2 = '194102309_u_1.wav';
a = dir(".\audio");
fs = 16000;     %sampling freq
a = a(3:end);

%computing 39 dim mfcc features for all the audios
for i = 1:length(a)
   aud = audioread(".\audio\"+a(i).name);
   [mf,delta,deltadelta] = mfcc(aud,fs,'LogEnergy','Ignore');
   [a(i).coeff] = [mf,delta,deltadelta]';  
end

aud1 = audioread(".\audio\"+file1);

aud2 = audioread(".\audio\"+file2);

%dtw for the selected audios after normalization
dtw(aud1/max(aud1),aud2/max(aud2));

%39 dim mfcc coeffs for normalized audios
[mf1,delta1,deltadelta1] = mfcc(aud1/max(aud1),fs,'LogEnergy','Ignore');
[mf2,delta2,deltadelta2] = mfcc(aud2/max(aud2),fs,'LogEnergy','Ignore');
mfcoeff1 = [mf1,delta1,deltadelta1]';
mfcoeff2 = [mf2,delta2,deltadelta2]';

%dtw wrt 39 dim mfcc coeffs of the normalized audios
[d, idx , idy]= dtw(mfcoeff1,mfcoeff2);
figure
plot(idx,idy);

%obtained distance
disp('Euclidean distance for aligning the 39 dim mfcc features is ')
disp(d)