class
    MANAGER

inherit
    EMPLOYEE

create
    make_with_reports -- Function to create a manager

feature -- Initialize

    make_with_reports (e_name: STRING; e_title: STRING; e_manager: STRING; office_num: INTEGER; e_reports: ARRAY [EMPLOYEE])
            -- Constructor
        do
            -- Initialize manager
            make_with_arguments (e_name, e_title, e_manager) -- Make employee
            office_number := office_num
reports := e_reports

        end

feature -- Acces

    office_number: INTEGER
    reports: ARRAY [EMPLOYEE]

end -- end class
