function output=evaluate_commands(commands)
    try
        eval(commands);
        output.error=0;
    catch err
        output.error=1;
    end
end