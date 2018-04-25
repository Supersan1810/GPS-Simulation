function result = recordSignal(duration,Fs)
% Records audio for the length *duration* (in s) using Fs as sample rate
% 
% ------------------------------------------------------------------------
% Copyright (c) 2018. J. Gente, S. García Bescós
% This code is released under the GNU General Public License Version 3.
%
% Project: Matlab Lecture, Hans Juergen Herrler
% Authors: Sandra García Bescós, Johanna Gente
% Version: 1.0
%-------------------------------------------------------------------------
%
% Input Parameters: 
%       double                  : duration              length of the record (in s)
%       double                  : Fs                    sample rate
% Output Parameters: 
%       double[duration/Fs,1]   : result                recorded Signal
%
% Other Output: 
%       none

Bits=16; Channels=1;
Recorder=audiorecorder(Fs,Bits,Channels);
record(Recorder,duration);
pause(duration);
result=getaudiodata(Recorder);

end

