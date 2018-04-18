%% 04.04.2018 Exercises in Lesson 5: Correlation
% Position eines Echos erkennen
%
% Project: Matlab Herrler
% Author: J.Gente
% Version: 1.0

% Variables:
%       
%      


%% read file
filename='Bsp_mit_Echo.wav';
[y,Fs]=audioread(filename);

%% get autocovariance with inbuild functions

N=length(y);
c=abs(xcov(y,'biased'));
c=c(end-N+1:end); %show only last N values
time=((0:N-1)/Fs)';
figure('Name','Covariance of Bsp_mit_Echo','NumberTitle','off'); plot(time,c);
title('Covariance of Bsp\_mit\_Echo');
xlabel('T (s)');ylabel('c');
[value,index]=max(c(20:end));
echoDelay=time(index);
fprintf("echo delay: %f s \n",echoDelay);

%% todo: covariance from scratch (more efficent)





