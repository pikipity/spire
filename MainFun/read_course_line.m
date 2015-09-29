function [keywords, contents] = read_course_line(line)
% Read one line in course text file
%
% Syntax: [keywords, contents] = read_course_line(line)
%
% Input:
%   line: one line (string) in course file, like
%       '<display>Hello</display> <p></p>'
% Output:
%   keywords: keywords (cell) which are corresponding to function name,
%       like {'display', 'p'}
%   contents: contents (cell) which are corresponding to function variable,
%       like {'Hello', ''}

[~, tokens]=regexp(line,'<(\w+).*>(.*)</\1>','match','tokens');
keywords=cell(1,length(tokens));
contents=cell(1,length(tokens));
for i=1:length(tokens)
    keywords{1}=tokens{i}{1};
    contents{1}=tokens{i}{2};
end

end

