function result = correlation(y,x)
% Summary: 
% 
% Matlab Herrler
%-------------------------------------------------------------------------
% Sandra García Bescós
% Matrikelnummer: 4869045
%-------------------------------------------------------------------------
%
% function syntax:
% function result = corellation(x,y)
% input parameter:  x            = signal
%                   y            = signal
% output parameter: 
%                   result       = corellation
%
%% Perform function

    N=length(y);
    x=[x;zeros(size(x))];
    x=x-mean(x);
    y=y-mean(y);
    result=zeros(1,N-1);
    for k=1:N
        for i=1:N
            result(1,k)=result(1,k)+x(i+k-1)*y(i);
        end
    end
    result=abs(result)/N;
end

