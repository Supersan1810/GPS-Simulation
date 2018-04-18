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
%                       pseudoT
%                       position
%                       t
%                       
%% constants:
%               [4,2] : SPEAKER_POS
SERIES_FILE="SAT_gold1023x5.txt";
DURATION=10;
FS=22050;
SAMPLENUM=1;
SPEAKERNUM=4;

%% Import series

importSeries=dlmread(SERIES_FILE);

%% Record signal

%recSignal=recordSignal(DURATION,FS);
[recSignal,~]=audioread("Testaufnahme1.wav");

%% calculate correlation and find max (find peaks)
consLength=length(importSeries)*SAMPLENUM; %considered Length
correlationArray=zeros(consLength,SPEAKERNUM);
for speakerN=1:SPEAKERNUM
    correlationArray(:,speakerN)=correlation(recSignal(1:consLength,1),importSeries(:,speakerN));
end

%% gps correction


%% plots and position on map








end