function output=course_blank_line(nothing)
    try
        disp(' ')
        output.error=0;
    catch err
        output.error=1;
    end
end