function result = recordSignal(duration,Fs)
% result = recordSignal(duration) 
%   input parameters:     
%       float:     duration                in s
%                   Fs
%   output parameters:    
%       double[N]:   result                 recorded Signal
%       

% Project: GPS Demo Herrler
% Author:  J.Gente
% Version: 1.0

%   variables: 
%       double[]    result
%       int         N                   array length
% x0,y0,k

Bits=16; Channels=1; %whatever, random
Recorder=audiorecorder(Fs,Bits,Channels);
record(Recorder,duration);
pause(duration);
result=getaudiodata(Recorder);
%soundsc(result,Fs); %play to debug

end

