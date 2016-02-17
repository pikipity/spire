function keywords_table=config_keywords_table()
% Generate keywords table for finding fuinctions easily
%
% Syntax: keywords_table=config_keywords_table()
%
% Output: 
%   keywords_table: one hashtable for keywords
table={'p',             'course_blank_line',...
       'disp',          'display_line',...
       'wait',          'wait_studnet',...
       'show_pro',      'disp_course_progrss',...
       'eval',          'evaluate_ans',...
       'verify',        'verify_ans',...
       };
keys=cell(1,length(table)/2);
vals=cell(1,length(table)/2);
for i=1:length(table)/2
    keys{i}=table{2*(i-1)+1};
    vals{i}=table{2*i};
end
keywords_table=containers.Map(keys,vals);

end