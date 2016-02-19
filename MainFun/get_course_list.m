function course_list=get_course_list()
    course_list={};
    list=dir('./Courses');
    list=list(3:end);
    for i=1:length(list)
        if list(i).isdir
            course_list{end+1}=list(i).name;
        end
    end
end