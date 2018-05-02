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
    
    
%% Nested Functions
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

    function result = correlation(x,y)
        
    % Calculates correlation function for x,y
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
    %       double[N]               : x              signal to correlate
    %       double[N]               : y              signal to correlate
    % Output Parameters: 
    %       double[N]               : result         calculated correlation vector
    %%

        N=min(length(y),length(x));
        y=[y;y];
        x=x-mean(x);
        y=y-mean(y);
        result=zeros(1,N);
        for k=1:N
            result(1,k)=abs(sum(y(k:N+k-1,1).*x(1:N,1)))/N;
        end
        result=abs(result)/N;
        result=fliplr(result); % for some reason only (y,x) works, so we flip the result
    end

    function [t0,position] = gpsCorrection(speakerPos, pseudoT)
    % Summary: calculates correct position and time_shift for given psuedo time
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
    % function syntax:
    % function 
    % input parameter:  speakerPos    = position of speakers 
    %                   pseudoT       = pseudo time from correlation
    % 
    % output parameter: 
    %                   t             = calculated time shift
    %                   position      = calculated position
    %

    %% Initialize values
        c = 343;
        t0 = 0;
        x = 4;
        y = 4;

    %% Solve LGS iteratively
        for i=1:10
            p = c * (pseudoT+t0);
            A = [ (x-speakerPos(1,1))/L(1), (y-speakerPos(1,2))/L(1), c ;
                  (x-speakerPos(2,1))/L(2), (y-speakerPos(2,2))/L(2), c ;
                  (x-speakerPos(3,1))/L(3), (y-speakerPos(3,2))/L(3), c ;
                  (x-speakerPos(4,1))/L(4), (y-speakerPos(4,2))/L(4), c ];
            b = p(1:4)-L(1:4);

            result=A\b;
            x=x+result(1); %delta x
            y=y+result(2); %delta y
            t0=result(3);
        end
        position = [x,y];
    
        %% Auxiliary function
        function l = L(speakerNo)
        % Summary: calcultes distance of current x and y to speaker 
        %          with index speakerNo
        % 
        % input parameter:  speakerNo     = speaker Index
        % 
        % output parameter: 
        %                   t             = calculated time shift
        %
        % global parameter: speakerPos    = position of speakers
        %                   x             = current x-position
        %                   y             = current y-position

        %% Calculate dustance to speaker 

            xSpeaker = speakerPos(speakerNo,1);
            ySpeaker = speakerPos(speakerNo,2);

            l=sqrt((xSpeaker-x).^2+(ySpeaker-y).^2);
        end

    end
    
    function generatePlots(importSeries, recSignal,correlationArray, maxSample,FS)
    % Summary: generates plots showing the recorded Signal and its correlation
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
    % function syntax:
    % function generatePlots(importSeries, recSignal,correlationArray, maxSample,FS)
    % input parameter:  importSeries        = series sounding through speakers
    %                   recSignal           = recorded Signal
    %                   correlationArray    = calculated correlation between
    %                                         signals
    %                   maxSamples          = peaks in correlation
    %                   FS                  = sample rate
    % 

    %% Plot: recorded Signal
        figure('Name','Recorded Signal','NumberTitle','off'); 
        t=(1:length(recSignal))/FS;
        plot(t,recSignal);
        title('Signal from all speakers');
        xlabel('t in sec');
        ylabel('');

    %% Plot: recorded Signal and expected Signal from speakers
        figure('Name','Recorded Signal and Speaker Signal','NumberTitle','off'); 
        window=1:100;
        subplot(5,1,1);
            plot(recSignal(window));
            title('recordedSignal');
        for i=1:4
            subplot(5,1,i+1);
                plot(importSeries(window,i));
                title(sprintf('Signal from speaker no %d',i));
        end

    %% Plot: correlation
        figure('Name','Correlation of Signals','NumberTitle','off'); 
        for i=1:4
            subplot(4,1,i);
                hold on
                timeVector=(1:length(correlationArray))'/FS*1000;
                plot(timeVector,correlationArray(:,i));
                scatter(maxSample(i)/FS*1000, correlationArray(maxSample(i),i));
                title(sprintf('Correlation to speaker no %d',i));
                hold off
        end

    end
    
    
end





