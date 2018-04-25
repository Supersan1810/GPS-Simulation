function gpsdemo4
% Summary: 
% 
% Matlab Herrler
%-------------------------------------------------------------------------
% Sandra García Bescós
% Matrikelnummer: 4869045
%-------------------------------------------------------------------------
%
% function syntax:
% function gpsdemo4
% input parameter:
% 
% output parameter: 
%                  
% variables:    
%               [*,4] : importSeries 
%               [*,1] : recSignal
%               [*,4] : correlationArray
%               [4,1] : pseudoT
%               [2,1] : position
%               [1,1] : t
%                       
%% constants:
SPEAKER_POS=[9.19,2.82;9.12,6.63;0.3,1.39;0.3,6.11];
SERIES_FILE="SAT_gold1023x5.txt";
%DURATION=10;
FS=22050;
SAMPLENUM=1;
SPEAKERNUM=4;

%% Import series

importSeries=dlmread(SERIES_FILE);

%% Record signal

l=ceil(length(importSeries)/FS);
%recSignal=recordSignal(l,FS);
%[recSignal,~]=audioread("Testaufnahme1.wav");
recSignal=evalin('base', 'recSignal');
assignin('base','recSignal',recSignal);

%% calculate correlation and find max (find peaks)
consLength=length(importSeries)*SAMPLENUM; %considered Length
correlationArray=zeros(consLength,SPEAKERNUM);
for speakerN=1:SPEAKERNUM
    correlationArray(:,speakerN)=correlation(recSignal(1:consLength,1),importSeries(:,speakerN));
end

[~,maxSample]=max(correlationArray(:,:));
pseudoT=maxSample'/FS;
%pseudoT=[0.153;0.158;0.162;0.163];

%% gps correction
    [t,position] = gpsCorrection(SPEAKER_POS, pseudoT);
    
%% map plot 
    Karte(position);

%% plots
    generatePlots(importSeries,recSignal,correlationArray,maxSample,FS);
    

    








end