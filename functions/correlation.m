function result = correlation(x,y)
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

    x=[x;zeros(size(x))];
    x=x-mean(x);
    N=length(x0);
    result=zeros(N-1,1);
    for k=1:N
        result(k,1)=abs(sum(x(k:N+k-1,1).*y(1:N,1)))/N;
    end
end