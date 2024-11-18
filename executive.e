note
	description: "Summary description for {EXECUTIVE}."
	author: "Matt Jolie, Matt Keefe, Paul O'Sullivan"
	date: "11/15/24"
	revision: "$Revision$"

class
    EXECUTIVE

inherit
    MANAGER
    	redefine
    		reports
    	end

create
    make_executive

feature -- Initialize
	--reports: ARRAYED_LIST[MANAGER]


    make_executive (e_name: STRING; e_title: STRING; e_manager: STRING; office: INTEGER; e_reports: ARRAYED_LIST[MANAGER]; conference_room: INTEGER)
            -- Constructor for an executive, including office, reports, and conference room number
        do
            make_with_reports(e_name, e_title, e_manager, office, e_reports) -- called from manager

            conference_room_number := conference_room

        end

feature -- Access

    conference_room_number: INTEGER
    reports: ARRAYED_LIST[MANAGER]



end -- end class
