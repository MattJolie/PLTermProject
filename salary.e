note
	description: "Defines an employee with a yearly salary compared to other types of compensation"
	author: "Matt Jolie, Matt Keefe, Paul O'Sullivan"
	date: "12/1/24"
	revision: "Everything in this file is new"

class
	SALARY

create
	make_with_salary

feature -- Initialization

	make_with_salary(pay: INTEGER)

	do
		yearly_salary := pay
	end

feature -- Access

	yearly_salary: INTEGER

end
