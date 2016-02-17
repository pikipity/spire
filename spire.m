%% Clear workspace
varlist=whos();
if ~isempty(varlist)
    questions='To run ''spire'', you need to clean your workspace. But there are variables in your workspace. Do you want to save them?';
    saveornot=questdlg(questions,'Save Workspace?',...
        'Yes','No','No');
    while isempty(saveornot)
        saveornot=questdlg(questions,'Save Workspace?',...
        'Yes','No','No');
    end
    switch saveornot
        case 'No'
            clear;clc;
        case 'Yes'
            variablenamelist=cell(1,length(varlist));
            for i=1:1:length(varlist)
                variablenamelist{i}=varlist(i).name;
            end
            uisave(variablenamelist,'workspace.mat');
            clear;clc;
    end
end
%% Initial
global SpireApp;
SpireApp.keywords_table=config_keywords_table();
SpireApp.state_table=config_state_table();
SpireApp.state=1;
%% Main
while 1
    switch SpireApp.state
        case SpireApp.state_table('quit')
            break;
        case SpireApp.state_table('begin')
            [SpireApp.linenum,SpireApp.lines,SpireApp.readcourse_error]=read_course('Welcome.course');
            if SpireApp.readcourse_error
                disp('Error: Course File Wrong')
                SpireApp.state=SpireApp.state_table('quit');
            else
                enter_course(SpireApp.linenum,SpireApp.lines);
                SpireApp.state=SpireApp.state_table('quit');
            end
    end
end
