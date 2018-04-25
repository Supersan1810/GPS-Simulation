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

    N=min(length(y),length(x));
    y=[y;zeros(size(y))];
    x=x-mean(x);
    y=y-mean(y);
    result=zeros(1,N);
    for k=1:N
        result(1,k)=abs(sum(y(k:N+k-1,1).*x(1:N,1)))/N;
    end
    result=abs(result)/N;
    %result=fliplr(result); % for some reason only (y,x) works, so we flip the result
end

        %{
            for n=1:N
                result(1,k)=result(1,k)+y(n+k-1,1).*x(n,1);
            end
        %}

