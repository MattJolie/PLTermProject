class
    EXECUTIVE

inherit
    MANAGER

create
    make_manager

feature -- Initialize

    make_manager (e_name: STRING; e_title: STRING; e_manager: STRING; office: INTEGER; e_reports: ARRAY [EMPLOYEE]; conference_room: INTEGER)
            -- Constructor for an executive, including office, reports, and conference room number
        do
            make_with_reports(e_name, e_title, e_manager, office, e_reports) -- called from manager

            conference_room_number := conference_room

        end

feature -- Access

    conference_room_number: INTEGER


end -- end class
