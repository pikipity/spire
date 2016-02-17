function [linenum,lines,error]=read_course(course_file)
% Read course file
%
% Syntax: [linenum,lines,error]=read_course(course_file)
%
% Input:
%   course_file: course file name (string) which must be included in path
%
% Output:
%   linenum: total line numbers
%   lines: all lines (cell)
%   error: a flag. 1: there is error. 0: there is not error.
global SpireApp;
lines={};
linenum=0;
fin=fopen(course_file);
error=0;
while ~feof(fin)
    temp=fgetl(fin);
    lines{linenum+1}=temp;
    linenum=linenum+1;
    [keywords, contents]=read_course_line(temp);
    if length(keywords)~=length(contents)
        error=1;
        break;
    end
    if ~isempty(find(ismember(keywords,SpireApp.keywords_table.keys)==0))
        error=1;
        break;
    end
end
fclose(fin);
end