%% Copyright 2014 MERCIER David
function model_doerner_nix_king
%% Function used to calculate Young's modulus in bilayer system with
% the model of Doerner & Nix (1986) modified by King (1987)
gui = guidata(gcf);

x = gui.results.t_corr./gui.results.ac;

% A(1) = Ef_red
% A(2) = alpha
bilayer_model = @(A, x) ...
    (1e-9*(((1./(1e9*A(1)))*(1-exp(-A(2)*x))) + ...
    ((1./gui.data.Es_red)*(exp(-A(2)*x)))).^-1);

% Make a starting guess
gui.results.A0 = [...
    str2double(get(gui.handles.value_youngfilm1_GUI, 'String')) / ...
    (1-gui.data.nuf.^2); 0.25];

OPTIONS = optimset('lsqcurvefit');
OPTIONS = optimset(OPTIONS, 'TolFun',  1e-20);
OPTIONS = optimset(OPTIONS, 'TolX',    1e-20);
OPTIONS = optimset(OPTIONS, 'MaxIter', 10000);
[gui.results.A, ...
    gui.results.resnorm, ...
    gui.results.residual, ...
    gui.results.exitflag, ...
    gui.results.output, ...
    gui.results.lambda, ...
    gui.results.jacobian] =...
    lsqcurvefit(bilayer_model, gui.results.A0, x, ...
    gui.results.Esample_red, ...
    [0;0], [1000;0.5], OPTIONS); % By default alpha = 0.25 in Doerner and Nix paper

gui.results.Ef_red_sol_fit(1) = gui.results.A(1);

gui.results.Ef_sol_fit(1) = gui.results.Ef_red_sol_fit(1) * ...
    (1-gui.data.nuf^2);

gui.results.Ef_sol_fit(2) = gui.results.A(2);

gui.results.Em_red = ...
    (1e-9*(((1./(1e9*gui.results.A(1)))*(1-exp(-gui.results.A(2)*x))) + ...
    ((1./gui.data.Es_red)*(exp(-gui.results.A(2)*x)))).^-1);

gui.results.Ef_red = 1e-9*(((1./(1e9.*gui.results.Esample_red)) - ...
    ((1./gui.data.Es_red)*(exp(-gui.results.A(2).*x))))./(1-exp(-gui.results.A(2).*x))).^-1;

guidata(gcf, gui);

end