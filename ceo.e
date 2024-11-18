note
	description: "Summary description for {CEO}."
	author: "Matt Keefe, Matt Jolie, Paulm O'Sullivan"
	date: "$Date$"
	revision: "$Revision$"

class
	CEO

inherit
	EXECUTIVE
		redefine
			reports
		end

create
	make_ceo

feature


	make_ceo(e_name: STRING; e_office: INTEGER; e_reports: ARRAYED_LIST[EXECUTIVE]; e_conf_room: INTEGER)

		do
			make_executive(e_name, "CEO", "NONE", e_office, e_reports, e_conf_room)

		end

feature
	reports: ARRAYED_LIST[EXECUTIVE] --Access

end
