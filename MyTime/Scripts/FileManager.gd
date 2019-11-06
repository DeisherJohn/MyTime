extends Node

	
func generate_single_csv(employee, file_loc = null, start = 0, end = null, simple = true):
	var get_times = dbManager.getShiftTimes(employee["eid"], start, end)
	
	if len(get_times) < 1:
		return false
	
	if file_loc == null:
		file_loc = settings.get_save_location() + employee["first_name"] + employee["last_name"] + str(OS.get_unix_time()) + ".csv"
		
	var keys = get_times[0].keys()
	
	var file = File.new()
	
	file.open(file_loc, file.WRITE)
	keys.append("Time Worked")
	file.store_csv_line(keys)
	
	for time in get_times:
		var line = PoolStringArray()
		for key in keys:
			if key == "signIn" or key == "signOut":
				line.append(convert_unixtime_to_string_time(time[key]))
			elif key == "Time Worked":
				line.append(get_time_between_shifts(time["signIn"], time["signOut"] ))
			else:
				line.append(time[key])
		
		file.store_csv_line(line)
	
	file.close()
	
	
	
func generate_all_employee_files(file_loc = null, start = 0, end = null, simple = true):
	
	#open file
	
	if file_loc == null:
		file_loc = settings.get_save_location() + "Report" + str(OS.get_unix_time()) + ".csv"
		
	var file = File.new()
	file.open(file_loc, file.WRITE)

	var keys = ["employee", "id", "signIn", "signOut", "Time Worked"]
	file.store_csv_line(keys)
		
	#get employee shifts
	
	var employees = dbManager.getEmployeeList(false)
	
	for employee in employees:
		var emp_name = employee["first_name"] + " " + employee["last_name"]
		var shifts = dbManager.getShiftTimes(employee["eid"])
		var total_time = 0.0
		
		for shift in shifts:
			var line = PoolStringArray()
			#name
			if not simple:
				line.append(emp_name)
				#id
				line.append(shift["id"])
				#signIn
				line.append(convert_unixtime_to_string_time(shift["signIn"]))
				#singOut
				line.append(convert_unixtime_to_string_time(shift["signOut"]))
				#TimeWorked
				line.append(get_time_between_shifts(shift["signIn"], shift["signOut"]))
				
				#add to file 
				file.store_csv_line(line)
				
			total_time += get_time_between_shifts(shift["signIn"], shift["signOut"])
			
		var empLine = PoolStringArray()
		empLine.append(emp_name)
		empLine.append("TOTAL TIME BETWEEN")
		empLine.append(convert_unixtime_to_string_time(start))
		empLine.append(convert_unixtime_to_string_time(end))
		empLine.append(total_time)
		file.store_csv_line(empLine)
		
	#employee, id, start, end, time
	
	#close file
	file.close()
	pass
	
	
	
func convert_unixtime_to_string_time(unixtime):
	var newTime = OS.get_datetime_from_unix_time(int(unixtime))
	var dateString = ""
	match settings.get_date_format():
		settings.DATE_FORMAT.DDMMYYYY:
			if newTime["day"] < 10: dateString += "0"
			dateString += str(newTime["day"]) + "/" 
			if newTime["month"] < 10: dateString += "0"
			dateString += str(newTime["month"]) + "/"
		settings.DATE_FORMAT.MMDDYYYY:
			if newTime["month"] < 10: dateString += "0"
			dateString += str(newTime["month"]) + "/"
			if newTime["day"] < 10: dateString += "0"
			dateString += str(newTime["day"]) + "/" 
			
	dateString += str(newTime["year"]) + " " 
	
	if newTime["hour"] < 10: dateString += "0"
	dateString += str(newTime["hour"]) + ":" 
	if newTime["minute"] < 10: dateString += "0"
	dateString += str(newTime["minute"]) 
	
	return dateString
	pass
	
func get_time_between_shifts(timeIn, timeOut):
	var timeWorked = timeOut - timeIn
	timeWorked = timeWorked/(60.0 * 60.0)
	timeWorked *= 10000
	timeWorked = round(timeWorked)
	timeWorked /= 10000.0
	return timeWorked
	
	pass
	
	
	
	
	
	
	
	