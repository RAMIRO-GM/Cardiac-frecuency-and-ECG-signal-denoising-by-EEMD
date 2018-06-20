%function [mi, ti]=emin(x)
%
%  
% Input-
%	        x	- vector of input data x(n)
% Output-
%	       mi	- vector that specifies min points
%	       ti	- vector that specifies the coordinates of min points
%
%NOTE:
%      give a 1D data-x   
%      The function EMIN returns the  min points and their coordinates.
%
%  Reference:
% Association: NFAM, NFAMSM, NFAMSMMULTI  
%     
%
%  code writer:Norden Huang (NASA GSFC)	November 11, 1999
% footnote:S.C.Su 2009/05/14
%
function [mi, ti]=emin(x)

% Calling sequence-
% [mi, ti]=emin(x)
% 
%  Initial

%----- Get dimensions
n=length(x);

%----- Initialize
n_x=1;
mi=0;
ti=0;

%----- Extract the set of max points and their coordinates
for i=2:n-1
   if (x(i-1)>x(i))&(x(i)<=x(i+1))
      mi=[mi x(i)];
      ti=[ti i];
      n_x=n_x+1;

   end
end

%----- Define the output
mi=mi(2:n_x);
ti=ti(2:n_x);

mi=mi';
ti=ti';