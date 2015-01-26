%% Copyright 2014 MERCIER David
function [beta, theta_eq, nu] = beta_Hay(theta_eq, nu, varargin)
%% Function used to plot beta parameter in function of the equivalent
% semi-angle for a conical indentet and in funciton of the Poisson's
% coefficient of the material indented.
% See Hay J.C. (1999) - DOI: 10.1557/JMR.1999.0306

if nargin < 2
    %nu = 0.3;
    nu = 0:0.02:0.5;
end

if nargin < 1
    theta_eq = 70.32; % Equivalent cone angle (in degrees) of the Berkovich indenter
    %theta_eq = 0:0.1:90;
end

if theta_eq > 60
    beta = pi .* (((pi/4) + ...
        (0.15483073.*cotd(theta_eq) .* ...
        ((1-2.*nu)./(4*(1-nu))))) ./ ...
        ((pi/2)-(0.83119312.*cotd(theta_eq) .* ...
        ((1-2.*nu)./(4.*(1-nu))))).^2);
else
    beta = 1 + ((1-2*nu) ./ ...
        (4.*(1-nu) .* tand(theta_eq)));
end

figure;

plot(nu, beta, 'b-', 'LineWidth', 2, 'MarkerSize', 10);
xlabel('\nu', 'Color', [0,0,0], 'FontSize', 14);

% plot(theta_eq, beta, 'b-', 'LineWidth', 2, 'MarkerSize', 10);
% xlabel('\theta_{eq} (�)', 'Color', [0,0,0], 'FontSize', 14);
% set(gca, 'xlim', [0,90]);
% set(gca, 'ylim', [0,2]);

ylabel('\beta', 'Color', [0,0,0], 'FontSize', 14);
set(gca, 'FontSize', 14);

grid on;

save_figure(pwd, gca, '_betaHay');

end