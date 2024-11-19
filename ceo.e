note
	description: "Summary description for {CEO}."
	author: "Matt Keefe, Matt Jolie, Paulm O'Sullivan"
	date: "$Date$"
	revision: "$Revision$"

class
	CEO

inherit
	EXECUTIVE


create
	make_ceo

feature


	make_ceo(e_name: STRING; e_office: INTEGER; e_conf_room: INTEGER)

		do
			make_executive(e_name, "CEO", "NONE", e_office, e_conf_room)

		end

feature


end
