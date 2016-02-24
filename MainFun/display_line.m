function output=display_line(line)
    try
        disp(line)
        output.error=0;
    catch err
        output.error=1;
    end
end