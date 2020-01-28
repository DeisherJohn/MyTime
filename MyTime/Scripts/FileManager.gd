extends Node


func _ready():
	
	pass



func generate_employee_csv(employee, file_loc = null, start = 0, end = null, simple = false):
	
	#Gets all the shifts this employee has between the dates
	var shifts = dbManager.getShiftTimes(employee["eid"], start, end)

	if len(shifts) < 1:
		#make sure that there is shifts
		return true
	
	if file_loc == null:
		#if no file is given, make a file name
		file_loc = settings.get_save_location() + employee["first_name"] + employee["last_name"] + str(OS.get_unix_time()) + ".csv"
	
	var file = File.new()
	
	var error = null
	
	var keys = null
	
	if settings.get_hr_mm():
		keys = ["employee", "id", "signIn", "signOut", "hours worked", "minutes worked"]
	else:
		keys = ["employee", "id", "signIn", "signOut", "time worked"]
		
	var existing_file = false
	
	if file.file_exists(file_loc):
		error = file.open(file_loc, file.READ_WRITE)
		file.seek_end()
		existing_file = true
	else:
		error = file.open(file_loc, file.WRITE)
	
	if error != OK:
		print("File error: %s" % error)
		return false
		
	if not existing_file:
		file.store_csv_line(keys) #Adds headers to the file
	
	var employee_name = employee["first_name"] + " " + employee["last_name"]
	var total_time = Dictionary()
	
	total_time["hours"] = 0
	total_time["minutes"] = 0
	
	for shift in shifts:
		var line = PoolStringArray()
			#name
		var time_between = get_time_between_shifts(shift["signIn"], shift["signOut"])
		
		if not simple:
			line.append(employee_name)
			#id
			line.append(shift["id"])
			#signIn
			line.append(convert_unixtime_to_string_time(shift["signIn"]))
			#singOut
			line.append(convert_unixtime_to_string_time(shift["signOut"]))
			#TimeWorked
			if settings.get_hr_mm():
				line.append(time_between["hours"])
				line.append(time_between["minutes"])
			else:
				line.append(time_between["report"])
			
			#add to file 
			file.store_csv_line(line)
		
		
		total_time["hours"] += int(time_between["hours"])
		total_time["minutes"] += int(time_between["minutes"])
		
	
	while total_time["minutes"] >= 60:
		total_time["minutes"] -= 60
		total_time["hours"] += 1
	
	#Tail for file
	var empLine = PoolStringArray()
	empLine.append(employee_name)
	empLine.append("TOTAL TIME BETWEEN")
	empLine.append(convert_unixtime_to_string_time(start))
	empLine.append(convert_unixtime_to_string_time(end))
	
	var dec_time
	
	if settings.get_hr_mm():
		empLine.append(total_time["hours"])
		empLine.append(total_time["minutes"])
	else:
		dec_time = total_time["hours"] + total_time["hours"]/60.0
		empLine.append(dec_time)
		
	file.store_csv_line(empLine)
	
	file.close()
	return true
	pass
	
	
func generate_all_employee_files(file_loc = null, start = 0, end = null, simple = true):
	
	#If no file given, make the file
	
	if file_loc == null:
		file_loc = settings.get_save_location() + "Report" + str(OS.get_unix_time()) + ".csv"
	
	#Get a list of all employees
	var employees = dbManager.getEmployeeList(false)

	
	for employee in employees:
		#for each employee, append to the given file
		var good_make = generate_employee_csv(employee, file_loc, start, end, simple)
		
		if not good_make:
			return false
			
	return true
	pass
	
	
	
func convert_unixtime_to_string_time(unixtime):
	
	
	
	if unixtime == null:
		unixtime = OS.get_datetime()
		unixtime = dbManager.get_time_offset(unixtime)
		
	if unixtime == 0:
		return "Still signed in"
		
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
	var return_dict = Dictionary()
	return_dict["time"] = 0
	return_dict["report"] = "0"
	return_dict["hours"] = 0
	return_dict["minutes"] = 0
	
	if timeIn > timeOut:
		return return_dict
	
	
	
	var timeWorked = timeOut - timeIn
	timeWorked = timeWorked/(60.0 * 60.0)
	timeWorked *= 10000
	timeWorked = round(timeWorked)
	timeWorked /= 10000.0
	return_dict["time"] = timeWorked
	
	var hrs = int(timeWorked)
	var mins = timeWorked - hrs
	
	mins *= 60
	mins = round(mins)
	
	if settings.get_hr_mm():
		if mins < 10: 
			mins = "0" + str(mins)
		
		return_dict["report"] = str(hrs) + ":" + str(mins)
	else:
		return_dict["report"] = timeWorked
	return_dict["hours"] = hrs
	return_dict["minutes"] = mins
	return return_dict
	
	pass
	
	
	
	
	
	
	
	