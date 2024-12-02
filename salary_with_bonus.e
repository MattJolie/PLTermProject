note
	description: "Defines an employee with a yearly salary and bonus potential compared to other types of compensation"
	author: "Matt Jolie, Matt Keefe, Paul O'Sullivan"
	date: "12/1/24"
	revision: "Everything in this file is new"


class
	SALARY_WITH_BONUS

create
	make_salary_with_bonus

feature -- Initialization

	make_salary_with_bonus(salary: INTEGER; bonus: INTEGER)

	do
		base := salary
		top := salary + bonus
	end

feature -- Access

	base: INTEGER
	top: INTEGER

end
