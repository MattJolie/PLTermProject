note
	description: "Defines an employee with a salary pay type"
	author: "Matt Jolie, Matt Keefe, Paul O'Sullivan"
	date: "12/1/24"
	revision: "Everything in this file is new"


class
	S_EMPLOYEE

inherit
	EMPLOYEE
	SALARY

create
	make_salaried_employee

feature -- Initialization

	make_salaried_employee(e_name: STRING; e_title: STRING; e_manager: STRING; e_pay: INTEGER)

	do
		make_with_arguments(e_name, e_title, e_manager)
		make_with_salary(e_pay)
	end

end
