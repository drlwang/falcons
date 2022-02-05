function [lat,lon,h]=xyz2ell2(X,Y,Z,a,e2)
% XYZ2ELL2  Converts cartesian coordinates to ellipsoidal.
%   Uses iterative alogithm with Bowring height formula
%   to improve convergence rate (see B.R. Bowring, "The
%   accuracy of geodetic latitude and height equations",
%   Survey Review, v28 #218, October 1985 pp.202-206).
%   Computation time is only slightly worse than for the
%   Bowring direct formula but accuracy is better.  Vectorized.
%   See also XYZ2ELL, XYZ2ELL2.
% Version: 25 Oct 96
% Useage:  [lat,lon,h]=xyz2ell2(X,Y,Z,a,e2)
% Input:   X \
%          Y  > vectors of cartesian coordinates in CT system (m)
%          Z /
%          a   - ref. ellipsoid major semi-axis (m)
%          e2  - ref. ellipsoid eccentricity squared
% Output:  lat - vector of ellipsoidal latitudes (radians)
%          lon - vector of ellipsoidal longitudes (radians)
%          h   - vector of ellipsoidal heights (m)
elat=1.e-12;
eht=1.e-5;
p=sqrt(X.*X+Y.*Y);
lat=atan2(Z,p./(1-e2));
h=0;
dh=1;
dlat=1;
while sum(dlat>elat) | sum(dh>eht)
  lat0=lat;
  h0=h;
  v=a./sqrt(1-e2.*sin(lat).*sin(lat));
  h=p.*cos(lat)+Z.*sin(lat)-(a*a)./v;  % Bowring formula
  lat=atan2(Z, p.*(1-e2.*v./(v+h)));
  dlat=abs(lat-lat0);
  dh=abs(h-h0);
end
lon=atan2(Y,X);
