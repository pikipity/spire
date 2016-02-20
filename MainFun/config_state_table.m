function state_table=config_state_table()
% Generate state table for finding states easily
%
% Syntax: state_table=config_state_table()
%
% Output: 
%   keywords_table: one hashtable for states
table={'quit',            -1,...
       'begin',           1,...
       'command',          2,...
       'help',             3,...
       'select_course',    4,...
       'enter_user',       5,...
       'begin_course',     6,...
       };
keys=cell(1,length(table)/2);
vals=cell(1,length(table)/2);
for i=1:length(table)/2
    keys{i}=table{2*(i-1)+1};
    vals{i}=table{2*i};
end
state_table=containers.Map(keys,vals);

end