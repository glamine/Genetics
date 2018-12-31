function FitnV = FPS( ObjV, Smul )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if nargin == 1
	Smul = 2 ;
end

Omin = min( ObjV ) ;
Omax = max( ObjV ) ;

m = Smul/(Omin - Omax);
p = - m * Omax;

FitnV = m*ObjV + p;

% if (Omin > ( Smul * Oave - Omax ) / ( Smul - 1.0 ))
% 	delta = Omax - Oave ;
% 	a = ( Smul - 1.0 ) * Oave / delta ;
% 	b = Oave * ( Omax - Smul * Oave ) / delta ;
% else
% 	delta = Oave - Omin ;
% 	a = Oave / delta ;
% 	b = -Omin * Oave / delta ;
% end
% 
% FitnV = ObjV.*a + b ;


end

