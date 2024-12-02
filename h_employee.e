note
	description: "Defines an employee with an hourly pay type"
	author: "Matt Jolie, Matt Keefe, Paul O'Sullivan"
	date: "12/1/24"
	revision: "Everything in this file is new"


class
	H_EMPLOYEE

inherit
	EMPLOYEE
	HOURLY

create
	make_hourly_employee

feature -- Initialization

	make_hourly_employee(e_name: STRING; e_title: STRING; e_manager: STRING; e_pay: INTEGER)

	do
		make_with_arguments(e_name, e_title, e_manager)
		make_hourly(e_pay)
	end

end
