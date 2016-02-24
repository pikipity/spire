function enter_course(linenum,lines)
% Main course function. It will display all course contants.
% Note: It will affect global variable SpireApp
%
% Syntax: enter_course(linenum,lines)
%
% Input:
%   linenum: total line numbers in lines
%   lines: a cell contain all lines in course
global SpireApp;
for i=1:linenum
    [keywords, contents]=read_course_line(lines{i});
    j=1;
    while j<=length(keywords)
        output=eval([SpireApp.keywords_table(keywords{j}),...
            '(''',...
            contents{j},...
            ''');']);
        if output.error==0
            j=j+1;
        else
            disp(['Uncorrect line ' num2str(j)])
            j=j+1;
        end
    end
%     for j=1:length(keywords)
%         output=eval([SpireApp.keywords_table(keywords{j}),...
%             '(''',...
%             contents{j},...
%             ''');']);
%     end
end
end