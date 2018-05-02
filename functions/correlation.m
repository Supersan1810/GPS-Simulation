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
