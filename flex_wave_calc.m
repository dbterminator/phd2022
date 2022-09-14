%% Phase speed for differential flexural element using Cremer 1973 eq.85
% Reference: Cremer, L. & Heckl, M. Structure-Borne Sound. Structure-Borne Sound (1973). doi:10.1007/978-3-662-10118-6.
%
% Author: Saif Bunni, Novemeber 2021
%
% Cite this work as: 
% Bunni, Saif and Nieminen, Heikki J., Needle Bevel Geometry Influences the Flexural Deflection 
% Magnitude in Ultrasound-Enhanced Fine-Needle Biopsy (July 9, 2021). 
% Available at SSRN: http://dx.doi.org/10.2139/ssrn.4199074
%
% This code is licensed under Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
% https://creativecommons.org/licenses/by-nc/4.0/

% frequency properties 
f2 = 10e3:1:100e3; % frequency
omega2 = 2.*pi.*f2; % angular frequency

% Material properties
rho2 = 8070; % kg/m3 
E2 = 205e9; % N/m2

% geometric properties (can be replaced by whatever cross-sectional area). 
b = 0.6e-3; % m, beam width (x?)
h = 10e-3; % m, beam height (y?)

% Cross-sectional area and mass per unit length.
% calculate according to equation appropriate for selected cross-sectional area.
S = b*h; % m2, total surface area of beam 
m_dash = rho2*S; % kg/m, mass per unit length

% moments of inertia
% change according to cross-sectional area
Ixx = b*(h^3)/12; % m4, Ixx
Iyy = (b^3)*h/12; % m4, Iyy

% Bending stiffnesses for Iyy and Ixx.
Bxx = E2*Ixx; % bending stiffness, cremer,
Byy = E2*Iyy; % bending stiffness, cremer,

% phase velocities for Bxx and Byy
% choose according to whether the bending is around the width or height of the cross-sectional area.
c_Bxx = ((Bxx/m_dash)^(1/4)).*(omega2.^(1/2)); % eq.85, m/s, phase velocity
c_Byy = ((Byy/m_dash)^(1/4)).*(omega2.^(1/2)); % eq.85, m/s, phase velocity

% calculate wavelength
lambda_Bxx = c_Bxx./f2; % m, lambda
lambda_Byy = c_Byy./f2; % m, lambda

% calculate an 'effective' flexural modulus N/m2 (made up parameter)
E_flex_xx = (c_Bxx.^2).*rho2; % N/m2
E_flex_yy = (c_Byy.^2).*rho2; % N/m2
