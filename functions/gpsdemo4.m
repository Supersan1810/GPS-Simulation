function gpsdemo4
% Calculates microphone position by calculation correlation on recorded audio
%
% Function Explanation: 
% There are 4 speakers in the testing room, that send a series of random
% numbers. This skript calculates the microphone position by calculation
% the distance to each of the the speakers using correlation function. 
% 
% ------------------------------------------------------------------------
% Copyright (c) 2018. J. Gente, S. García Bescós
% This code is released under the GNU General Public License Version 3.
%
% Project: Matlab Lecture, Hans Juergen Herrler
% Authors: Sandra García Bescós, Johanna Gente
% Version: 1.0
% -------------------------------------------------------------------------
%
% Input Parameters: 
%       none
% Output Parameters: 
%       none
%
% Other Output: 
%   Plots of 
%       recorded signal
%       parts of recorded signal and random series
%       all correlation functions
%       calculated position on room map
%
% Important Variables:    
%       double[*,4] : importSeries          Srandom number series used      
%       double[*,1] : recSignal             recorded signal
%       double[*,4] : correlationArray      correlation result
%       double[4,1] : pseudoT               temporary T calculated by correlation result
%       double[2,1] : position              final calculated position
%       double[1,1] : t                     final calculated time of record start
%       double      : l                     length of recording (in s)
%       double[1,SPEAKERNUM]: maxSample     correlation sample number with maximum amplitude    
%       int         : consLength            number of used samples from record

%% Constants
SPEAKER_POS=[9.19,2.82;9.12,6.63;0.3,1.39;0.3,6.11];
SERIES_FILE="SAT_gold1023x5.txt";
FS=22050;
SAMPLENUM=1;
SPEAKERNUM=4;

%% Import Series
importSeries=dlmread(SERIES_FILE);

%% Record Signal

% get record from workspace
recSignal=evalin('base', 'recSignal');

% get record from microphone
% l=ceil(length(importSeries)/FS);
% recSignal=recordSignal(l,FS);
% assignin('base','recSignal',recSignal);

%% Calculate Correlation and Find Max (Find Peaks)
consLength=length(importSeries)*SAMPLENUM;
correlationArray=zeros(consLength,SPEAKERNUM);
for speakerN=1:SPEAKERNUM
    correlationArray(:,speakerN)=correlation(recSignal(1:consLength,1),importSeries(:,speakerN));
end

[~,maxSample]=max(correlationArray(:,:));
pseudoT=maxSample'/FS;

%% GPS Correction
    [t,position] = gpsCorrection(SPEAKER_POS, pseudoT);
    
%% Map Plot 
    Karte(position);

%% Generate Plots
    generatePlots(importSeries,recSignal,correlationArray,maxSample,FS);

end