note
	description: "Basic definition of the employee constructor class. Parent class for types of employees"
	author: "Matt Jolie, Matt Keefe, Paul O'Sullivan"
	date: "11/13/24"
	revision: "$Revision$"

class
    EMPLOYEE

create
    make_with_arguments

feature -- Initialization

    make_with_arguments (e_name: STRING; e_title: STRING; e_manager: STRING)

    do
        name := e_name
        title := e_title
        manager := e_manager
    end

feature -- Access

    name: STRING
    title: STRING
    manager: STRING

end -- end class
