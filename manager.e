note
	description: "Summary description for {MANAGER}."
	author: "Matt Jolie, Matt Keefe, Paul O'Sullivan"
	date: "11/15/24"
	revision: "$Revision$"

class
    MANAGER

inherit
    EMPLOYEE

create
    make_with_reports -- Function to create a manager

feature -- Initialize


    make_with_reports (e_name: STRING; e_title: STRING; e_manager: STRING; office_num: INTEGER;)
            -- Constructor
        do
            -- Initialize manager
            make_with_arguments (e_name, e_title, e_manager) -- Make employee
            office_number := office_num


        end

feature -- Acces

    office_number: INTEGER


end -- end 
