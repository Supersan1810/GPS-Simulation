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
% input parameter:  i             = 
% 
% output parameter: 
%                   0 = 
% variables:    
%               [*,4] : importSeries 
%               [*,1] : recSignal
%                       correlation
%                       pseudoT
%               [2,4] : speakerPos
%                       position
%                       t
%                       
%% Perform function
%% Import series


%% Record signal


%% calculate correlation and find max (find peaks)


%% gps correction
    [t,position] = gpsCorrection(SPEAKER_POS, pseudoT);

%% plots and position on map
    Karte(position);
    generatePlots(importSeries, recSignal,correlationArray);







end