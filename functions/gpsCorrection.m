function [t0,position] = gpsCorrection(speakerPos, pseudoT)
% Summary: calculates correct position and time_shift for given psuedo time
% 
% 
% Matlab Herrler
%-------------------------------------------------------------------------
% Sandra García Bescós
% Matrikelnummer: 4869045
%-------------------------------------------------------------------------
%
% function syntax:
% function 
% input parameter:  SpeakerPos    = position of Speakers 
%                   pseudoT       = psuedo time from correlation
% 
% output parameter: 
%                   t             = calculated time shift
%                   position      = calculated position
%
%% Perform function
    
    %initialize values
    c = 343;
    t0 = 0;
    x = 4;
    y = 4;
    
    %solve LGS iteratively
    for i=1:10
        p = c * (pseudoT+t0);
        A = [ x-speakerPos(1,1)/L(1,x,y), y-SpeakerPos(1,2)/L(1,x,y), c ;
              x-speakerPos(2,1)/L(2,x,y), y-SpeakerPos(2,2)/L(2,x,y), c ;
              x-speakerPos(3,1)/L(3,x,y), y-SpeakerPos(3,2)/L(3,x,y), c ;
              x-speakerPos(4,1)/L(4,x,y), y-SpeakerPos(4,2)/L(4,x,y), c ];
        b = p(1:4)-L(1:4);

        result=A\b;
        x=result(1);
        y=result(2);
        t0=result(3);
    end
    position = [x,y];
    

function l = L(speakerNo)
    xSpeaker = speakerPos(speakerNo,1);
    ySpeaker = speakerPos(speakerNo,2);
    l=sqrt(sqr(xSpeaker-x)+sqr(ySpeaker-y));
end

end