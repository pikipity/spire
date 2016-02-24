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
else
    clear;clc;
end
%
global SpireApp;
% Add path
SpireApp.filepath=fileparts([mfilename('fullpath') '.m']);
cd(SpireApp.filepath)
addpath(genpath('./'))
%% Initial
SpireApp.keywords_table=config_keywords_table();
SpireApp.state_table=config_state_table();
SpireApp.state=1;
SpireApp.user='';
SpireApp.curnum=1;
SpireApp.course='';
SpireApp.play_mode=0;
%% Main
while 1
    switch SpireApp.state
        case SpireApp.state_table('quit')
            [SpireApp.linenum,SpireApp.lines,SpireApp.readcourse_error]=read_course('Quit.course');
            if SpireApp.readcourse_error
                disp('Error: Help File Wrong')
            else
                enter_course(SpireApp.linenum,SpireApp.lines);
            end
            break;
        case SpireApp.state_table('begin')
            [SpireApp.linenum,SpireApp.lines,SpireApp.readcourse_error]=read_course('Welcome.course');
            if SpireApp.readcourse_error
                disp('Error: Welcome File Wrong')
            else
                enter_course(SpireApp.linenum,SpireApp.lines);
            end
            SpireApp.state=SpireApp.state_table('command');
        case SpireApp.state_table('help')
            [SpireApp.linenum,SpireApp.lines,SpireApp.readcourse_error]=read_course('Help.course');
            if SpireApp.readcourse_error
                disp('Error: Help File Wrong')
            else
                enter_course(SpireApp.linenum,SpireApp.lines);
            end
            SpireApp.state=SpireApp.state_table('command');
        case SpireApp.state_table('command')
            SpireApp.incommand=input('>> ','s');
            switch strtrim(SpireApp.incommand)
                case ''
                case 'help'
                    SpireApp.state=SpireApp.state_table('help');
                case 'quit'
                    SpireApp.state=SpireApp.state_table('quit');
                case 'select_course'
                    if isempty(SpireApp.user)
                        SpireApp.state=SpireApp.state_table('enter_user');
                    else
                        SpireApp.temp='';
                        while isempty(SpireApp.temp)
                            SpireApp.temp=questdlg(questions,['Do you want to use ''' SpireApp.user ''' to begin your course?'],...
                            'Yes','No','No');
                        end
                        switch SpireApp.temp
                            case 'Yes'
                                SpireApp.state=SpireApp.state_table('select_course');
                            case 'No'
                                SpireApp.state=SpireApp.state_table('enter_user');
                        end
                    end
                otherwise
                    disp('Unknown command')
                    SpireApp.state=SpireApp.state_table('help');
            end
        case SpireApp.state_table('enter_user')
            SpireApp.user='';
            while isempty(SpireApp.user)
                SpireApp.user=input('Please enter your user name: ','s');
            end
            SpireApp.state=SpireApp.state_table('select_course');
        case SpireApp.state_table('select_course')
            SpireApp.temp='';
            if exist(['UserData/' SpireApp.user '.mat'])
                while isempty(SpireApp.temp)
                    SpireApp.temp=questdlg(questions,[SpireApp.user 'already registed. Do you want to continue previous progress?'],...
                    'Yes','No','No');
                end
            else
                SpireApp.temp='No';
            end
            switch SpireApp.temp
                case 'Yes'
                    load(['UserData/' SpireApp.user '.mat']);
%                     SpireApp.state=SpireApp.state_table('command');
                case 'No'
                   SpireApp.courselist=get_course_list();
                    if isempty(SpireApp.courselist)
                        disp('There is not any course.')
                        SpireApp.state=SpireApp.state_table('command');
                    else
                        [SpireApp.course,~] = listdlg('PromptString','Select a course:',...
                                'SelectionMode','single',...
                                'ListString',SpireApp.courselist);
                         if isempty(SpireApp.course)
                             disp('You didn''t select any course.')
%                              SpireApp.state=SpireApp.state_table('command');
                         else
                             disp(['You select ''' SpireApp.course ''' course.'])
%                              SpireApp.state=SpireApp.state_table('command');
                         end
                         SpireApp.state=SpireApp.state_table('begin_course');
                    end 
            end
        case SpireApp.state_table('begin_course');
            if ~exist(['courses/' SpireApp.course '/' SpireApp.course '.course'])
                disp(['There is not ''' 'courses/' SpireApp.course '/' SpireApp.course '.course' ''' file. Please check this course.'])
                SpireApp.state=SpireApp.state_table('command');
            else
                [SpireApp.linenum,SpireApp.lines,SpireApp.readcourse_error]=read_course(['courses/' SpireApp.course '/' SpireApp.course '.course']);
                if SpireApp.readcourse_error
                    disp(['''' 'courses/' SpireApp.course '/' SpireApp.course '.course' ''' file Wrong. Please check this course.'])
                else
                    enter_course(SpireApp.linenum,SpireApp.lines);
                end
                SpireApp.state=SpireApp.state_table('command');
            end
    end
end
% Remove path
cd(SpireApp.filepath)
rmpath(genpath('./'))
% Remove App Data
clear SpireApp