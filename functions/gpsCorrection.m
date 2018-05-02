function [t0,position] = gpsCorrection(speakerPos, pseudoT)
% Summary: calculates correct position and time_shift for given psuedo time
% 
% ------------------------------------------------------------------------
% Copyright (c) 2018. J. Gente, S. Garc�a Besc�s
% This code is released under the GNU General Public License Version 3.
%
% Project: Matlab Lecture, Hans Juergen Herrler
% Authors: Sandra Garc�a Besc�s, Johanna Gente
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