note
	description: "Defines a 'Hourly' employee as a contrast to other kinds of compensation"
	author: "Matt Jolie, Matt Keefe, Paul O'Sullivan"
	date: "12/1/24"
	revision: "Everything in this file is new"

class
	HOURLY

create
	make_hourly

feature -- Initialization

	make_hourly(pay: INTEGER)

	do
		hourly_rate := pay
	end

feature -- Access

	hourly_rate: INTEGER

end
