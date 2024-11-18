note
	description: "Root class for a company employee management application"
	authors: "Made by  Matt Keefe, Matt Jolie, Paul O'Sullivan  "
	date: "$Date: 2024/11/4 15:0:35 $"
	revision: "1.1.1"

class
	APPLICATION

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
		local
			l_app: EV_APPLICATION
		do
			create l_app
			prepare
			l_app.launch
		end

	prepare
		local
			box: EV_VERTICAL_BOX -- https://www.eiffel.org/files/doc/static/24.05/libraries/vision2/ev_vertical_box_chart.html
			title_label: EV_LABEL -- https://www.eiffel.org/files/doc/static/24.05/libraries/vision2/ev_label_chart.html
			font: EV_FONT -- https://www.eiffel.org/files/doc/static/24.05/libraries/vision2/ev_font_chart.html
		do
			create_interface_objects
			create box.default_create
			create title_label.default_create
			title_label.set_text ("Welcome to the Company Management Program!")

			create font.default_create
			font.set_height (16)
			title_label.set_font (font)

			box.extend (title_label)
			box.extend (add_employee_button)
			box.extend (remove_employee_button)
			box.extend (display_company_tree_button)
			box.extend (print_employee_info_button)
			box.extend (update_employee_button)
			box.extend (search_employee_button)
			box.extend (quit_button)

			create main_window.default_create
			main_window.put (box)
			main_window.set_title ("Company Designer")
			main_window.set_size (400, 300)

			create employee_arr.make (0)  --Create globally
			create manager_arr.make (0)
			create exec_arr.make (0)

			main_window.show

			quit_button.select_actions.extend (agent quit_application)
			add_employee_button.select_actions.extend (agent show_add_employee_interface)
			remove_employee_button.select_actions.extend (agent show_remove_interface)
			display_company_tree_button.select_actions.extend (agent display_tree)
			print_employee_info_button.select_actions.extend (agent print_employee_info)
			update_employee_button.select_actions.extend (agent edit_employee)
			search_employee_button.select_actions.extend (agent search_employee)

		end

	create_interface_objects
		do
			-- Create buttons and their properties
			create add_employee_button.default_create
			add_employee_button.set_text ("Add Employee")
			add_employee_button.set_minimum_size (150, 30)

			create remove_employee_button.default_create
			remove_employee_button.set_text ("Remove Employee")
			remove_employee_button.set_minimum_size (150, 30)

			create display_company_tree_button.default_create
			display_company_tree_button.set_text ("Display Company Tree")
			display_company_tree_button.set_minimum_size (150, 30)

			create print_employee_info_button.default_create
			print_employee_info_button.set_text ("Print Employee Information")
			print_employee_info_button.set_minimum_size (150, 30)

			create update_employee_button.default_create
			update_employee_button.set_text ("Update Employee Information")
			update_employee_button.set_minimum_size (150, 30)

			create search_employee_button.default_create
			search_employee_button.set_text ("Search For Employee")
			search_employee_button.set_minimum_size (150, 30)

			create quit_button.default_create
			quit_button.set_text ("Quit Application")
			quit_button.set_minimum_size (150, 30)
		end

feature -- Buttons for home page

	add_employee_button: EV_BUTTON -- https://www.eiffel.org/files/doc/static/24.05/libraries/vision2/ev_button_chart.html
	remove_employee_button: EV_BUTTON
	display_company_tree_button: EV_BUTTON
	print_employee_info_button: EV_BUTTON
	update_employee_button: EV_BUTTON
	search_employee_button: EV_BUTTON
	quit_button: EV_BUTTON

feature -- Arrays for staff

	employee_arr: ARRAYED_LIST [EMPLOYEE] -- https://www.eiffel.org/doc/solutions/EiffelBase_Data_Structures%2C_Lists Resizable
	manager_arr: ARRAYED_LIST [MANAGER]
	exec_arr: ARRAYED_LIST [EXECUTIVE]

feature {NONE} -- implementation of the Add Employee feature

	show_add_employee_interface
		local
			add_employee_window: EV_WINDOW
			input_box: EV_VERTICAL_BOX
			name_label: EV_LABEL
			name_input: EV_TEXT_FIELD
			job_title_label: EV_LABEL
			job_title_dropdown: EV_COMBO_BOX -- https://www.eiffel.org/files/doc/static/24.05/libraries/vision2/ev_combo_box_chart.html
			work_mode_label: EV_LABEL
			work_mode_dropdown: EV_COMBO_BOX
			continue_button: EV_BUTTON
			back_button: EV_BUTTON
			job_titles: ARRAYED_LIST [STRING_32] -- https://www.eiffel.org/files/doc/static/24.05/libraries/base/arrayed_list_chart.html
			work_modes: ARRAYED_LIST [STRING_32]
		do
			create add_employee_window.default_create
			add_employee_window.set_title ("Add New Employee")
			add_employee_window.set_size (400, 300)

			create input_box.default_create

			create name_label.default_create
			name_label.set_text ("Add Employee Name:")

			create name_input.default_create
			name_input.set_text ("") -- starts with an empty input for users entry

			create job_title_label.default_create
			job_title_label.set_text ("Select Job Title:")

			create job_title_dropdown.default_create
			create job_titles.make (0)
			job_titles.extend ("Employee")
			job_titles.extend ("Manager")
			job_titles.extend ("Executive")
			job_titles.extend ("CEO")
			job_title_dropdown.set_strings (job_titles)
			--XX
			create work_mode_label.default_create
			work_mode_label.set_text ("Select Work Mode:")

			create work_mode_dropdown.default_create
			create work_modes.make (0)
			work_modes.extend ("In-Person")
			work_modes.extend ("Hybrid")
			work_modes.extend ("Remote")
			work_mode_dropdown.set_strings (work_modes)
			--XX
			-- adds a Continue Button
			create continue_button.default_create
			continue_button.set_text ("Continue")
			continue_button.select_actions.extend (agent process_employee_input (name_input, job_title_dropdown, work_mode_dropdown))

			-- adds a Back to Main Page Button
			create back_button.default_create
			back_button.set_text ("Back to Main Page")
			back_button.select_actions.extend (agent return_to_main_page (add_employee_window))

			input_box.extend (name_label)
			input_box.extend (name_input)
			input_box.extend (job_title_label)
			input_box.extend (job_title_dropdown)
			input_box.extend (work_mode_label) --X
			input_box.extend (work_mode_dropdown) --X
			input_box.extend (continue_button)
			input_box.extend (back_button)

			add_employee_window.put (input_box)
			add_employee_window.show
		end

	return_to_main_page (current_window: EV_WINDOW) -- feature
		do
			-- closes the current add employee window
			if attached current_window as l_window then
				l_window.destroy
			end
			main_window.show
		end

	process_employee_input (a_name_input: EV_TEXT_FIELD; a_job_title_dropdown: EV_COMBO_BOX; a_work_mode_dropdown: EV_COMBO_BOX) -- feature
	local
		confirm_window: EV_WINDOW
		confirm_box: EV_VERTICAL_BOX
		info_label: EV_LABEL
		job_title_text, work_mode_text: STRING
		manager_dropdown: EV_COMBO_BOX
		manager_list: ARRAYED_LIST [STRING_32]
		executive_dropdown: EV_COMBO_BOX
		executive_list: ARRAYED_LIST [STRING_32]
		office_number_label: EV_LABEL
		office_number_input: EV_TEXT_FIELD
		conference_room_label: EV_LABEL
		conference_room_input: EV_TEXT_FIELD
		executive_title_label, manager_title_label: EV_LABEL
		finalize_button: EV_BUTTON
		remote_label: EV_LABEL
		i: INTEGER
		-- Temps for creation & add to array
		staff_emp: EMPLOYEE
		staff_manager: MANAGER
		staff_exec: EXECUTIVE
	do
		-- default values
		job_title_text := "Unknown Job Title"
		work_mode_text := "Unknown Work Mode"

		-- attached ensures references are not void (used this in Snowman too, will need to talk about in presentation)
		if attached a_job_title_dropdown.selected_item as job_item then
			job_title_text := job_item.text
		end

		if attached a_work_mode_dropdown.selected_item as work_item then
			work_mode_text := work_item.text
		end

		-- retrieves and prints basic employee information
		create confirm_window.default_create
		confirm_window.set_title ("Confirm New Employee")
		confirm_window.set_size (400, 300)

		create confirm_box.default_create

		create info_label.default_create
		info_label.set_text ("Employee Info: " + a_name_input.text + " (" + job_title_text + ") - " + work_mode_text)
		confirm_box.extend (info_label)

		-- *** TODO: this is where variables can be stored into node on the tree

		-- conditional statements for additional information
		if job_title_text.is_equal ("Employee") then
			-- creates a title label for manager dropdown
			create manager_title_label.default_create
			manager_title_label.set_text ("Select the Manager that " + a_name_input.text + " reports to:")
			confirm_box.extend (manager_title_label)


			create manager_dropdown.default_create
			create manager_list.make(manager_arr.count)

			-- Goes through global manager array now
			from
				i := 1
			until
				i > manager_arr.count
			loop
				manager_list.extend (manager_arr.at (i).name)
			end

		manager_dropdown.set_strings (manager_list)
		confirm_box.extend (manager_dropdown)
		create staff_emp.make_with_arguments (a_name_input.text, a_job_title_dropdown.text, manager_dropdown.selected_text)
		employee_arr.put_front (staff_emp)



		elseif job_title_text.is_equal ("Manager") then

			-- title label for executive dropdown
			create executive_title_label.default_create
			executive_title_label.set_text ("Select the Executive that " + a_name_input.text + " reports to:")
			confirm_box.extend (executive_title_label)

			create executive_dropdown.default_create
			create executive_list.make (0)

			-- Goes through global executive array
			from
				i := 1
			until
				i > exec_arr.count
			loop
				executive_list.extend (exec_arr.at (i).name)
			end
			executive_dropdown.set_strings (executive_list)
			confirm_box.extend (executive_dropdown)
			-- Ensure office_number_input is attached and handle it accordingly
			if attached office_number_input as office_input then
    			create staff_manager.make_with_reports (a_name_input.text, a_job_title_dropdown.text, executive_dropdown.selected_text, office_input.text.to_integer, employee_arr.to_array)
    			manager_arr.put_front (staff_manager)
			else

    			create staff_manager.make_with_reports (a_name_input.text, a_job_title_dropdown.text, executive_dropdown.selected_text, 100, employee_arr.to_array) -- Temp have not been able to work around the error object may be void, this fixes but not allowing for input
				manager_arr.put_front (staff_manager)
			end


		elseif job_title_text.is_equal ("Executive") then
			-- adds a label for CEO reporting
			create info_label.default_create
			info_label.set_text ("Reports to: CEO")
			confirm_box.extend (info_label)
		end

		-- handles office/conference room input based on work mode
		if work_mode_text.is_equal ("In-Person") or work_mode_text.is_equal ("Hybrid") then
			if job_title_text.is_equal ("Manager") then
				create office_number_label.default_create
				office_number_label.set_text ("Enter Office Number:")
				confirm_box.extend (office_number_label)

				create office_number_input.default_create
				office_number_input.set_text ("") -- Empty input box
				confirm_box.extend (office_number_input)

			elseif job_title_text.is_equal ("Executive") then
				create conference_room_label.default_create
				conference_room_label.set_text ("Enter Conference Room Number:")
				confirm_box.extend (conference_room_label)

				create conference_room_input.default_create
				conference_room_input.set_text ("")
				confirm_box.extend (conference_room_input)
				if attached conference_room_input as conference_input then
	    			create staff_exec.make_manager (a_name_input.text, a_job_title_dropdown.text, "CEO", 200, manager_arr.to_array, 250) -- Default 200 for executive office
	    			exec_arr.put_front (staff_exec)
				else
	    			create staff_exec.make_manager (a_name_input.text, a_job_title_dropdown.text, "CEO", 200, manager_arr.to_array, 250) -- Default 200 for executive office
	    		    exec_arr.put_front (staff_exec)
				end
			end
		else
			create remote_label.default_create
			remote_label.set_text (a_name_input.text + " is not in the office and works remotely.")
			confirm_box.extend (remote_label)
		end

		-- adds finalize button
		create finalize_button.default_create
		finalize_button.set_text ("Finalize")
		finalize_button.select_actions.extend (agent finalize_action (a_name_input, a_job_title_dropdown, a_work_mode_dropdown, confirm_window))
		confirm_box.extend (finalize_button)

		confirm_window.put (confirm_box)
		confirm_window.show
	end

	finalize_action (name_input: EV_TEXT_FIELD; job_dropdown: EV_COMBO_BOX; work_dropdown: EV_COMBO_BOX; current_window: EV_WINDOW)
		do
			-- resets the name input to an empty string
			name_input.set_text ("")

			-- resets the job dropdown to the first title in the dropdown
			if attached job_dropdown.strings as job_list then
				job_dropdown.set_text (job_list.first)
			end

			-- resets work mode dropdown to the first description in the dropdown
			if attached work_dropdown.strings as work_list then
				work_dropdown.set_text (work_list.first)
			end

			-- closes the current confirm window
			if attached current_window as l_window then
				l_window.destroy
			end

			-- returns to the main window
			main_window.show
		end


feature {NONE} -- Implementation of the remove employee button

	show_remove_interface
		local
			remove_employee_window: EV_WINDOW
			input_box: EV_VERTICAL_BOX
			back_button: EV_BUTTON
			employee_dropdown: EV_COMBO_BOX
			manager_dropdown: EV_COMBO_BOX
			executive_dropdown: EV_COMBO_BOX
			e_label: EV_LABEL
			m_label: EV_LABEL
			exec_label: EV_LABEL
			employee_button: EV_BUTTON
			manager_button: EV_BUTTON
			executive_button: EV_BUTTON
			i: INTEGER
			employee_list, manager_list, executive_list: ARRAYED_LIST [STRING] -- lists for the dropdowns
			selected_employee_name: STRING_32
		do
			create remove_employee_window.default_create
			remove_employee_window.set_title ("Remove an Employee")
			remove_employee_window.set_size (400, 300)


			create input_box.default_create -- Main Interaction Page

			-- Employee Dropdown
			create e_label
			e_label.set_text ("Select Employee")
			create employee_dropdown.default_create
			create employee_list.make (employee_arr.count)

			from
				i := 1
			until
				i > employee_arr.count
			loop
				employee_list.extend (employee_arr.at (i).name)
				i := i + 1
			end
			employee_dropdown.set_strings (employee_list)
			input_box.extend (e_label)
			input_box.extend (employee_dropdown)


			-- Manager Dropdown
			create manager_dropdown.default_create
			create m_label
			m_label.set_text ("Select Manager")
			create manager_list.make (manager_arr.count)
			from
				i := 1
			until
				i > manager_arr.count
			loop
				manager_list.extend (manager_arr.at (i).name)
				i := i + 1
			end
			manager_dropdown.set_strings (manager_list)
			input_box.extend (m_label)
			input_box.extend (manager_dropdown)

			-- Executive Dropdown
			create executive_dropdown.default_create
			create exec_label
			exec_label.set_text ("Select Executive")

			create executive_list.make (exec_arr.count)
			from
				i := 1
			until
				i > exec_arr.count
			loop
				executive_list.extend (exec_arr.at (i).name)
				i := i + 1
			end
			executive_dropdown.set_strings (executive_list)
			input_box.extend (exec_label)
			input_box.extend (executive_dropdown)

			-- Delete logic based on which button pressed
			create employee_button.default_create
			employee_button.set_text ("Delete Employee Selected")
			create manager_button.default_create
			manager_button.set_text ("Delete Manager Selected")
			create executive_button.default_create
			executive_button.set_text ("Deleted Executive Selected")

			employee_button.select_actions.extend (agent delete_employee(employee_dropdown.selected_text, remove_employee_window))
		    manager_button.select_actions.extend (agent delete_employee (manager_dropdown.selected_text, remove_employee_window))
			executive_button.select_actions.extend (agent delete_employee(executive_dropdown.selected_text, remove_employee_window))

			create back_button.default_create
			back_button.set_text ("Back")
			back_button.select_actions.extend (agent return_to_main_page (remove_employee_window))


			input_box.extend (employee_button)
			input_box.extend (manager_button)
			input_box.extend (executive_button)
			input_box.extend (back_button)

			remove_employee_window.put (input_box)

			remove_employee_window.show
		end -- end show_remove_interface

	delete_employee (staff_name: STRING_32; curr_window: EV_WINDOW)
    	local
       		i: INTEGER
        	is_found: BOOLEAN
    	do
        	is_found := False

       		-- Search & delete employee array
        	from
            	i := 1
        	until
            	i > employee_arr.count or else is_found
        	loop
            	if employee_arr.at(i).name.is_equal(staff_name) then
                	employee_arr.remove_i_th(i)
                	is_found := True
            	end
            	i := i + 1
        	end

        	-- Search & delete manager array
        	if not is_found then
            	from
                	i := 1
            	until
                	i > manager_arr.count or else is_found
            	loop
                	if manager_arr.at(i).name.is_equal(staff_name) then
                    	manager_arr.remove_i_th (i)
                    	is_found := True
               		end
                	i := i + 1
           		end
        	end

        	-- Search & delete executive array
        	if not is_found then
            	from
                	i := 1
           		until
                	i > exec_arr.count or else is_found
           		loop
                	if exec_arr.at(i).name.is_equal(staff_name) then
                    	exec_arr.remove_i_th (i)
                    	is_found := True
                	end
                	i := i + 1
            	end
        	end

        	if attached curr_window as l_window then
            	l_window.destroy
        	end

        	-- Show the main window again
        	main_window.show
   	 end -- end delete_staff



feature

	quit_application
		do
			if attached main_window as l_window then
				l_window.destroy
			end
		end

	display_tree
		do
			io.put_string ("Displaying Tree Work")
		end

	print_employee_info
		do
			io.put_string ("Printing works")
		end

	edit_employee
		do
			io.put_string ("Edit Workss")
		end

	search_employee
		do
			io.put_string ("Searching Works")
		end

feature {NONE} -- Implementation

	main_window: EV_WINDOW -- The main window of the application

end
