function generatePlots(importSeries, recSignal,correlationArray, maxSample,FS)
% Summary: generates plots showing the recorded Signal and its correlation
% 
% Matlab Herrler
%-------------------------------------------------------------------------
% Sandra García Bescós
% Matrikelnummer: 4869045
%-------------------------------------------------------------------------
%
% function syntax:
% function generatePlots(importSerie, recSignal,correlation) 
% input parameter:  importSeries    = series sounding thorugh speakers
%                   recSignal       = recorded Signal
%                   correlationArray     = calculated correlation between
%                                     signals
% 
%
%% Perform function

%% Plot: recorded Signal
    figure('Name','Recorded Signal','NumberTitle','off'); 
    t=(1:length(recSignal))/FS;
    plot(t,recSignal);
    title('Signal from all speakers');
    xlabel('');
    ylabel('');

%% Plot: recorded Signal and expected Signal from speakers
    figure('Name','Recorded Signal and Speaker Signal','NumberTitle','off'); 
    window=20:40;
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