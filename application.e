note
	description: "Root class for a company employee management application"
	authors: "Made by  Matt Keefe, Matt Jolie, Paul O'Sullivan"
	date: "$Date: 2024/11/4 15:0:35 $"
	revision: "Tuple based storage was added"
	revision: "Necessary variable, constructor, and GUI changes made to acccomodate multiple inheritance"

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
			box: EV_VERTICAL_BOX
			title_label: EV_LABEL
			font: EV_FONT
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
			box.extend (print_employee_info_button)
			box.extend (quit_button)

			create main_window.default_create
			main_window.put (box)
			main_window.set_title ("Company Designer")
			main_window.set_size (400, 300)

			create employee_tuple_arr.make (0)

			main_window.show

			quit_button.select_actions.extend (agent quit_application)
			add_employee_button.select_actions.extend (agent show_add_employee_interface)
			remove_employee_button.select_actions.extend (agent show_remove_interface)
			print_employee_info_button.select_actions.extend (agent show_staff_interface)
		end

	create_interface_objects
		do
			create add_employee_button.default_create
			add_employee_button.set_text ("Add Employee")
			add_employee_button.set_minimum_size (150, 30)

			create remove_employee_button.default_create
			remove_employee_button.set_text ("Remove Employee")
			remove_employee_button.set_minimum_size (150, 30)

			create print_employee_info_button.default_create
			print_employee_info_button.set_text ("Print Employee Information")
			print_employee_info_button.set_minimum_size (150, 30)

			create quit_button.default_create
			quit_button.set_text ("Quit Application")
			quit_button.set_minimum_size (150, 30)
		end

feature -- buttons for home page

	add_employee_button: EV_BUTTON
	remove_employee_button: EV_BUTTON
	print_employee_info_button: EV_BUTTON
	quit_button: EV_BUTTON

feature -- ADDED FEATURE: tuple-based storage for employee data

	employee_tuple_arr: ARRAYED_LIST [TUPLE [name: STRING; job_title: STRING; work_mode: STRING; pay_type: STRING]]

feature {NONE} -- add employee feature

	show_add_employee_interface
		local
			add_employee_window: EV_WINDOW
			input_box: EV_VERTICAL_BOX
			name_label: EV_LABEL
			name_input: EV_TEXT_FIELD
			job_title_label: EV_LABEL
			job_title_dropdown: EV_COMBO_BOX
			work_mode_label: EV_LABEL
			work_mode_dropdown: EV_COMBO_BOX
			continue_button: EV_BUTTON
			back_button: EV_BUTTON
			job_titles: ARRAYED_LIST [STRING_32]
			work_modes: ARRAYED_LIST [STRING_32]
--********* Pay related fields ***************************************************************************************************
			pay_type_label: EV_LABEL
			pay_type_dropdown: EV_COMBO_BOX
			pay_types: ARRAYED_LIST [STRING_32]
			pay_amount_label: EV_LABEL
			pay_amount_input: EV_TEXT_FIELD
--********************************************************************************************************************************
		do
			create add_employee_window.default_create
			add_employee_window.set_title ("Add New Employee")
			add_employee_window.set_size (400, 300)

			create input_box.default_create

			create name_label.default_create
			name_label.set_text ("Add Employee Name:")

			create name_input.default_create
			name_input.set_text ("") -- starts with an empty input for user entry

			create job_title_label.default_create
			job_title_label.set_text ("Select Job Title:")

			create job_title_dropdown.default_create
			create job_titles.make (0)
			job_titles.extend ("Employee")
			job_titles.extend ("Manager")
			job_titles.extend ("Executive")
			job_titles.extend ("CEO")
			job_title_dropdown.set_strings (job_titles)

			create work_mode_label.default_create
			work_mode_label.set_text ("Select Work Mode:")

			create work_mode_dropdown.default_create
			create work_modes.make (0)
			work_modes.extend ("In-Person")
			work_modes.extend ("Hybrid")
			work_modes.extend ("Remote")
			work_mode_dropdown.set_strings (work_modes)

--********* New field added for multiple inheritance *****************************************************************************
			create pay_type_label.default_create
			pay_type_label.set_text ("Select Pay Type:")

			create pay_type_dropdown.default_create
			create pay_types.make (0)
			pay_types.extend ("Hourly")
			pay_types.extend ("Salary")
			pay_type_dropdown.set_strings (pay_types)

			create pay_amount_label.default_create
			pay_amount_label.set_text ("Pay ($)")

			create pay_amount_input.default_create
			pay_amount_input.set_text ("")
--********************************************************************************************************************************

			create continue_button.default_create
			continue_button.set_text ("Continue")
			continue_button.select_actions.extend (agent process_employee_input (name_input, job_title_dropdown, work_mode_dropdown, pay_type_dropdown, pay_amount_input))

			create back_button.default_create
			back_button.set_text ("Back to Main Page")
			back_button.select_actions.extend (agent return_to_main_page (add_employee_window))

			input_box.extend (name_label)
			input_box.extend (name_input)
			input_box.extend (job_title_label)
			input_box.extend (job_title_dropdown)
			input_box.extend (work_mode_label)
			input_box.extend (work_mode_dropdown)
--********* Pay related fields ***************************************************************************************************
			input_box.extend (pay_type_label)
			input_box.extend (pay_type_dropdown)
			input_box.extend (pay_amount_label)
			input_box.extend (pay_amount_input)
--********************************************************************************************************************************
			input_box.extend (continue_button)
			input_box.extend (back_button)

			add_employee_window.put (input_box)
			add_employee_window.show
		end

	return_to_main_page (current_window: EV_WINDOW)
		do
				-- closes the current add employee window
			if attached current_window as l_window then
				l_window.destroy
			end
			main_window.show
		end

feature -- helper methods for populating dropdown boxes

		-- ADDED FEATURE: populates manager list from the tuple
	populate_manager_list: ARRAYED_LIST [STRING_32]
		local
			manager_list: ARRAYED_LIST [STRING_32]
			i: INTEGER
		do
			create manager_list.make (0)
			from
				i := 1
			until
				i > employee_tuple_arr.count
			loop
				if employee_tuple_arr.at (i).job_title.is_equal ("Manager") then
					manager_list.extend (employee_tuple_arr.at (i).name)
				end
				i := i + 1
			end
			Result := manager_list
		end

		-- ADDED FEATURE: populates executive list from the tuple
	populate_executive_list: ARRAYED_LIST [STRING_32]
		local
			executive_list: ARRAYED_LIST [STRING_32]
			i: INTEGER
		do
			create executive_list.make (0)
			from
				i := 1
			until
				i > employee_tuple_arr.count
			loop
				if employee_tuple_arr.at (i).job_title.is_equal ("Executive") then
					executive_list.extend (employee_tuple_arr.at (i).name)
				end
				i := i + 1
			end
			Result := executive_list
		end

feature -- feature for processing employee input
--********** This was modified to include pay type info **************************************************************************
	process_employee_input (a_name_input: EV_TEXT_FIELD; a_job_title_dropdown: EV_COMBO_BOX; a_work_mode_dropdown: EV_COMBO_BOX; a_pay_type_dropdown: EV_COMBO_BOX; a_pay_amount_input: EV_TEXT_FIELD)
		local
			confirm_window: EV_WINDOW
			confirm_box: EV_VERTICAL_BOX
			info_label: EV_LABEL
			ok_button: EV_BUTTON
			job_title_text, work_mode_text, pay_type_text: STRING
			manager_dropdown, executive_dropdown: EV_COMBO_BOX
			manager_list, executive_list: ARRAYED_LIST [STRING_32]
			office_number_label, conference_room_label, manager_dropdown_label, executive_dropdown_label: EV_LABEL
			office_number_input, conference_room_input: EV_TEXT_FIELD
			remote_label: EV_LABEL

				-- ADDED FEATURE: TUPLE data structure
			new_employee: TUPLE [name: STRING_8; job_title: STRING_8; work_mode: STRING_8; pay_type: STRING_8]

				-- ADDED FEATURE: Local variables for employee creation
			new_employee_object: detachable EMPLOYEE
			pay_amount: INTEGER
			pay_info_label: EV_LABEL

		do
				-- default values to avoid problems from null/void values
			job_title_text := "Unknown Job Title"
			work_mode_text := "Unknown Work Mode"
			pay_type_text := "Unknown Pay Cycle"

				-- ensures the dropdown selections are not void
			if attached a_job_title_dropdown.selected_item as job_item then
				job_title_text := job_item.text
			end

			if attached a_work_mode_dropdown.selected_item as work_item then
				work_mode_text := work_item.text
			end

			if attached a_pay_type_dropdown as pay_type then
				pay_type_text := pay_type.text
			end

				-- ADDED FEATURE: Changes the pay amount input to an integer or 0 if it is void
			if attached a_pay_amount_input.text as pay_text then
				pay_amount := pay_text.to_integer
			else
				pay_amount := 0
			end

				-- ADDED FEATURE: creates and populates the employee tuple
			create new_employee.default_create
			new_employee.put_reference (a_name_input.text.string.to_string_8, 1)
			new_employee.put_reference (job_title_text.string, 2)
			new_employee.put_reference (work_mode_text.string, 3)
			new_employee.put_reference (pay_type_text.string, 4)

				-- ADDED FEATURE: assigns the appropriate employee class
			if pay_type_text.is_equal ("Hourly") then
				create {H_EMPLOYEE} new_employee_object.make_hourly_employee (new_employee.name, new_employee.job_title, "Unknown Manager", pay_amount)
			elseif pay_type_text.is_equal ("Salary") then
				create {S_EMPLOYEE} new_employee_object.make_salaried_employee (new_employee.name, new_employee.job_title, "Unknown Manager", pay_amount)
			else
				create {EMPLOYEE} new_employee_object.make_with_arguments (new_employee.name, new_employee.job_title, "Unknown Manager")
			end

				-- ADDED FEATURE: adds the employee tuple to the array
			employee_tuple_arr.put_front (new_employee)

				-- ADDED FEATURE: populates manager/executive lists
			manager_list := populate_manager_list
			executive_list := populate_executive_list

				-- creates the confirm window
			create confirm_window.default_create
			confirm_window.set_title ("Confirm New Employee")
			confirm_window.set_size (400, 300)

			create confirm_box.default_create

				-- adds employee info to the confirm box
			create info_label.default_create
			info_label.set_text ("Employee Info: " + new_employee.name + " (" + new_employee.job_title + ") - " + new_employee.work_mode)
			confirm_box.extend (info_label)

				-- ADDED FEATURE: adds salary or hourly pay info to the confirm box
			create pay_info_label.default_create
			if pay_type_text.is_equal ("Hourly") then
				pay_info_label.set_text ("Worker Type: Hourly | Hourly Rate: $" + pay_amount.out)
			elseif pay_type_text.is_equal ("Salary") then
				pay_info_label.set_text ("Worker Type: Salaried | Yearly Salary: $" + pay_amount.out)
			else
				pay_info_label.set_text ("Worker Type: Unknown | Pay Amount: $" + pay_amount.out)
			end
			confirm_box.extend (pay_info_label)

				-- conditional logic for dropdowns and additional inputs
			if job_title_text.is_equal ("Employee") then

				create manager_dropdown_label.default_create
				manager_dropdown_label.set_text ("Select Manager:")
				confirm_box.extend (manager_dropdown_label)

				create manager_dropdown.default_create
				manager_dropdown.set_strings (manager_list)
				confirm_box.extend (manager_dropdown)

			elseif job_title_text.is_equal ("Manager") then

				create executive_dropdown_label.default_create
				executive_dropdown_label.set_text ("Select Executive:")
				confirm_box.extend (executive_dropdown_label)

				create executive_dropdown.default_create
				executive_dropdown.set_strings (executive_list)
				confirm_box.extend (executive_dropdown)

			end

				-- adds a room number input box based on work mode
			if work_mode_text.is_equal ("In-Person") or work_mode_text.is_equal ("Hybrid") then

					-- adds office number input box for managers
				if job_title_text.is_equal ("Manager") then
					create office_number_label.default_create
					office_number_label.set_text ("Enter Office Number:")
					confirm_box.extend (office_number_label)

					create office_number_input.default_create
					office_number_input.set_text ("")
					confirm_box.extend (office_number_input)

						-- adds conference room number input box for executives
				elseif job_title_text.is_equal ("Executive") then
					create conference_room_label.default_create
					conference_room_label.set_text ("Enter Conference Room Number:")
					confirm_box.extend (conference_room_label)

					create conference_room_input.default_create
					conference_room_input.set_text ("")
					confirm_box.extend (conference_room_input)
				end
			else
					-- displays a message for remote employees
				create remote_label.default_create
				remote_label.set_text (new_employee.name + " works remotely and does not require a room number.")
				confirm_box.extend (remote_label)
			end

				-- adds the Finalize button
			create ok_button.default_create
			ok_button.set_text ("Finalize")
			ok_button.select_actions.extend (agent finalize_action (a_name_input, a_job_title_dropdown, a_work_mode_dropdown, a_pay_type_dropdown, a_pay_amount_input, confirm_window))
			confirm_box.extend (ok_button)

				-- shows the confirm window
			confirm_window.put (confirm_box)
			confirm_window.show
		end

	finalize_action (name_input: EV_TEXT_FIELD; job_dropdown: EV_COMBO_BOX; work_dropdown: EV_COMBO_BOX; pay_type: EV_COMBO_BOX; pay_amount: EV_TEXT_FIELD; current_window: EV_WINDOW)
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

feature -- remove employee feature

	show_remove_interface
		local
			remove_employee_window: EV_WINDOW
			input_box: EV_VERTICAL_BOX
			back_button: EV_BUTTON
			employee_dropdown, manager_dropdown, executive_dropdown: EV_COMBO_BOX
			employee_button, manager_button, executive_button: EV_BUTTON
			e_label, m_label, exec_label: EV_LABEL
			i: INTEGER
			employee_list, manager_list, executive_list: ARRAYED_LIST [STRING]
		do
			create remove_employee_window.default_create
			remove_employee_window.set_title ("Remove an Employee")
			remove_employee_window.set_size (400, 300)

			create input_box.default_create

				-- employee dropdown box (ADDED FEATURE: code iterates thorugh tuple array insated of regular arrays)
			create e_label.default_create
			e_label.set_text ("Select Employee")
			create employee_dropdown.default_create
			create employee_list.make (0)
			from
				i := 1
			until
				i > employee_tuple_arr.count
			loop
				if employee_tuple_arr.at (i).job_title.is_equal ("Employee") then
					employee_list.extend (employee_tuple_arr.at (i).name)
				end
				i := i + 1
			end
			employee_dropdown.set_strings (employee_list)
			input_box.extend (e_label)
			input_box.extend (employee_dropdown)

				-- manager dropdown box
			create m_label.default_create
			m_label.set_text ("Select Manager")
			create manager_dropdown.default_create
			create manager_list.make (0)
			from
				i := 1
			until
				i > employee_tuple_arr.count
			loop
				if employee_tuple_arr.at (i).job_title.is_equal ("Manager") then
					manager_list.extend (employee_tuple_arr.at (i).name)
				end
				i := i + 1
			end
			manager_dropdown.set_strings (manager_list)
			input_box.extend (m_label)
			input_box.extend (manager_dropdown)

				-- executive dropdown box
			create exec_label.default_create
			exec_label.set_text ("Select Executive")
			create executive_dropdown.default_create
			create executive_list.make (0)
			from
				i := 1
			until
				i > employee_tuple_arr.count
			loop
				if employee_tuple_arr.at (i).job_title.is_equal ("Executive") then
					executive_list.extend (employee_tuple_arr.at (i).name)
				end
				i := i + 1
			end
			executive_dropdown.set_strings (executive_list)
			input_box.extend (exec_label)
			input_box.extend (executive_dropdown)

				-- delete buttons
			create employee_button.default_create
			employee_button.set_text ("Delete Employee Selected")
			employee_button.select_actions.extend (agent delete_employee (employee_dropdown.selected_text, remove_employee_window))
			input_box.extend (employee_button)

			create manager_button.default_create
			manager_button.set_text ("Delete Manager Selected")
			manager_button.select_actions.extend (agent delete_employee (manager_dropdown.selected_text, remove_employee_window))
			input_box.extend (manager_button)

			create executive_button.default_create
			executive_button.set_text ("Delete Executive Selected")
			executive_button.select_actions.extend (agent delete_employee (executive_dropdown.selected_text, remove_employee_window))
			input_box.extend (executive_button)

				-- back button
			create back_button.default_create
			back_button.set_text ("Back")
			back_button.select_actions.extend (agent return_to_main_page (remove_employee_window))
			input_box.extend (back_button)

				-- finalizes and displays the window
			remove_employee_window.put (input_box)
			remove_employee_window.show
		end

	delete_employee (staff_name: STRING_32; curr_window: EV_WINDOW)
		local
			i: INTEGER
			is_found: BOOLEAN
		do
			is_found := False

				-- searches and deletes from the employee tuple (ADDED FEATURE: iterates through tuple array instead of original arrays)
			from
				i := 1
			until
				i > employee_tuple_arr.count or else is_found
			loop
				if employee_tuple_arr.at (i).name.is_equal (staff_name) then
					employee_tuple_arr.remove_i_th (i)
					is_found := True
				end
				i := i + 1
			end

				-- displays an error message if not found
			if not is_found then
				io.put_string ("Employee not found: " + staff_name + "%N")
			end

				-- closes the current window
			if attached curr_window as l_window then
				l_window.destroy
			end

				-- shows the main window again
			main_window.show
		end

feature -- show staff information window

	show_staff_interface
		local
			show_staff_window: EV_WINDOW
			input_box: EV_VERTICAL_BOX
			employee_button: EV_BUTTON
			back_button: EV_BUTTON
		do
			create show_staff_window.default_create
			show_staff_window.set_title ("View Staff Directories")
			show_staff_window.set_size (400, 300)

			create input_box.default_create
			create employee_button.default_create
			create back_button.default_create
			employee_button.set_text ("Print Employees")
			back_button.set_text ("Go Back")

			input_box.extend (employee_button)
			input_box.extend (back_button)

			employee_button.select_actions.extend (agent print_employee_information)
			back_button.select_actions.extend (agent return_to_main_page (show_staff_window))

			show_staff_window.put (input_box)
			show_staff_window.show
		end

feature -- feature for printing employee information

	print_employee_information
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > employee_tuple_arr.count
			loop
					-- ADDED FEATURE: added pay type (salary vs. hourly)
				io.put_string ("Employee: " + employee_tuple_arr.at (i).name + " - " + employee_tuple_arr.at (i).job_title + " (" + employee_tuple_arr.at (i).work_mode + ", " + employee_tuple_arr.at (i).pay_type + ")%N")
				i := i + 1
			end
		end

feature -- quits the application

	quit_application
		do
			if attached main_window as l_window then
				l_window.destroy
			end
		end

feature {NONE} -- Implementation

	main_window: EV_WINDOW

end
