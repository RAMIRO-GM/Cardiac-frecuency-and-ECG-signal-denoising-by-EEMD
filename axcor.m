function [r,lags] = axcor(x,y);
% Function to calculate auto- or crosscorrelation
%  Inputs
%       x,y   input signals (one for autocorrelation)
%  Outputs
%        r   correlation (normalized to 1 for autocorrelation
%        lags   vector of lags useful in plotting
%        norm   specifies normalization
%
if nargin == 1
    y = x;  % Preform autocorrelaton
end
%    
[N,lx] = size(x); 
if N > lx        % Rearange as row vector 
   x = x';						
   lx = N;
end  
[N,ly] = size(y);
if N > ly       % Rearange as row vector  
   y = y';						
   ly = N;
end 
% Make x1 the longer vector 
if lx < ly
    y1 = x;
    x1 = y;
else
    y1 = y;
    x1 = x;
end
ly = length(y1);                % Length of shorter array
N = length(x1);                 % Length of longer array. Used for normalization
x1 = [zeros(1,ly) x1 zeros(1,ly-1)];    % Now extend the of x to include +/-x
lx = length(x1);           % Length of longer
vary = var(y1);
for n = 1:lx-ly                    % Shift over full range
    r(n) = (1/N)*sum(y1 .* x1(n:n+ly-1));  % Shift to be compatable with MATLAB's xcorr
    lags(n) = round(n - ly - 1);
    if nargin == 2
       varx =var(x1(n:n+ly-1));
       if varx > 0 && vary > 0
            r(n) = r(n)/sqrt(varx*vary);     % Correlation normalization
       end
    end  
end
if nargin ==  1
    r = r/max(r);   % Autocorrelation normalization
end    

   
        