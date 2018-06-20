%  function [spmax, spmin, flag]= extrema(in_data)
%
% This is a utility program for cubic spline envelope,
%   the code is to  find out max values and max positions
%                            min values and min positions
%    (then use matlab function spline to form the spline)
%
%   function [spmax, spmin, flag]= extrema(in_data)
%
% INPUT:
%       in_data: Inputted data, a time series to be sifted;
% OUTPUT:
%       spmax: The locations (col 1) of the maxima and its corresponding
%              values (col 2)
%       spmin: The locations (col 1) of the minima and its corresponding
%              values (col 2)
%
% NOTE:
%      EMD uses Cubic Spline to be the Maximun and Minimum Envelope for
%        the data.Besides finding spline,end points should be noticed. 
%
%References:  ? which paper?
% 
%
%
% code writer: Zhaohua Wu. 
% footnote:S.C.Su
%
% There are two seperste loops in this code .
% part1.-- find out max values and max positions 
%          process the start point and end point  
% part2.-- find out min values and max positions 
%          process the start point and end point  
% Those parts are similar.
%
% Association:eemd.m
% this function ususally used for finding spline envelope
%
% Concerned function: no
%                     (all matlab internal function)

function [spmax, spmin, flag]= extrema(in_data)

flag=1;
dsize=length(in_data);

%part1.--find local max value and do end process

%start point 
%spmax(1,1)-the first 1 means first point max value,the second 1 means first index
%spmax(1,2)-the first 1 means first point max value,the second 2 means first index
%spmax(1,1)-for position of max 
%spmax(1,2)-for value    of max

spmax(1,1) = 1;
spmax(1,2) = in_data(1);

%Loop --start find max by compare the values 
%when [ (the jj th value > than the jj-1 th value ) AND (the jj th value > than the jj+1 th value )
%the value jj is the position of the max
%the value in_data (jj) is the value of the max
%do the loop by index-jj
%after the max value is found,use index -kk to store in the matrix
%kk=1,the start point
%the last value of kk ,the end point 

jj=2;
kk=2;
while jj<dsize,
    if ( in_data(jj-1)<=in_data(jj) & in_data(jj)>=in_data(jj+1) )
        spmax(kk,1) = jj;
        spmax(kk,2) = in_data (jj);
        kk = kk+1;
    end
    jj=jj+1;
end

%end point
spmax(kk,1)=dsize;
spmax(kk,2)=in_data(dsize);

%End point process-please see reference about spline end effect
%extend the slpoe of neighbor 2 max value ---as extend value
%original value of end point -----as original value
%compare extend and original value 

if kk>=4
    slope1=(spmax(2,2)-spmax(3,2))/(spmax(2,1)-spmax(3,1));
    tmp1=slope1*(spmax(1,1)-spmax(2,1))+spmax(2,2);
    if tmp1>spmax(1,2)
        spmax(1,2)=tmp1;
    end

    slope2=(spmax(kk-1,2)-spmax(kk-2,2))/(spmax(kk-1,1)-spmax(kk-2,1));
    tmp2=slope2*(spmax(kk,1)-spmax(kk-1,1))+spmax(kk-1,2);
    if tmp2>spmax(kk,2)
        spmax(kk,2)=tmp2;
    end
else
    flag=-1;
end

%these 4 sentence seems useless.
msize=size(in_data);
dsize=max(msize);
xsize=dsize/3;
xsize2=2*xsize;


%part2.--find local min value and do end process
%the syntax are all similar with part1.
%here-explan with beginning local max-find upper starting envelope
%the end process procedure-find out the neighbor 2 local extrema value
%connect those 2 local extrema and extend the line to the end
%make judgement with 1).line extend value  2).original data value
%the bigger value is chosen for upper envelope end control point

%local max 
spmin(1,1) = 1;
spmin(1,2) = in_data(1);
jj=2;
kk=2;
while jj<dsize,
    if ( in_data(jj-1)>=in_data(jj) & in_data(jj)<=in_data(jj+1))
        spmin(kk,1) = jj;
        spmin(kk,2) = in_data (jj);
        kk = kk+1;
    end
    jj=jj+1;
end


%local min
spmin(kk,1)=dsize;
spmin(kk,2)=in_data(dsize);

if kk>=4
    slope1=(spmin(2,2)-spmin(3,2))/(spmin(2,1)-spmin(3,1));
    tmp1=slope1*(spmin(1,1)-spmin(2,1))+spmin(2,2);
    if tmp1<spmin(1,2)
        spmin(1,2)=tmp1;
    end

    slope2=(spmin(kk-1,2)-spmin(kk-2,2))/(spmin(kk-1,1)-spmin(kk-2,1));
    tmp2=slope2*(spmin(kk,1)-spmin(kk-1,1))+spmin(kk-1,2);
    if tmp2<spmin(kk,2)
        spmin(kk,2)=tmp2;
    end
else
    flag=-1;
end

flag=1;