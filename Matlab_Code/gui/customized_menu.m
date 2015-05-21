%% Copyright 2014 MERCIER David
function customized_menu(parent)
%% Setting of customized menu
% parent: handle of the GUI

yaml_menu = uimenu(parent, 'Label', 'YAML File');

uimenu(yaml_menu, ...
    'Label', ...
    'Edit YAML config. file', ...
    'Callback', ...
    'edit_YAML_config_file');

uimenu(yaml_menu, ...
    'Label', ...
    'Load YAML config. file', ...
    'Callback', ...
    ['gui = guidata(gcf);',...
    '[gui.config.indenter, gui.config.data, '...
    'gui.config.numerics] = load_YAML_config_file;' ...
    'guidata(gcf, gui);']);

help_menu = uimenu(parent, 'Label', 'Help NIMS_Toolbox');

uimenu(help_menu, ...
    'Label', ...
    'HTML Documentation', ...
    'Callback', ...
    'gui = guidata(gcf); web(gui.config.url_help,''-browser'')');

uimenu(help_menu, ...
    'Label', ...
    'PDF Documentation', ...
    'Callback', ...
    'gui = guidata(gcf); web(gui.config.pdf_help,''-browser'')');

end