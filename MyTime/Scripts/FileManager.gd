extends Node

const DEFAULT_FILE_LOC = "C:/Users/John Deisher/Documents/GitHub/MyTime/Reports/"

func _ready():
	var emp = Dictionary()
	emp["eid"] =1000
	generate_single_csv(dbManager.getEmployee(1000))
	
	pass
	
func generate_single_csv(employee, file_loc = null, start = 0, end = null):
	var get_times = dbManager.getShiftTimes(employee["eid"], start, end)
	
	if len(get_times) < 1:
		return false
	
	if file_loc == null:
		file_loc = DEFAULT_FILE_LOC + employee["first_name"] + employee["last_name"] + str(OS.get_unix_time()) + ".csv"
		
	var keys = get_times[0].keys()
	
	var file = File.new()
	
	file.open(file_loc, file.WRITE)
	keys.append("Time Worked")
	file.store_csv_line(keys)
	
	for time in get_times:
		var line = PoolStringArray()
		for key in keys:
			if key == "signIn" or key == "signOut":
				var newTime = OS.get_datetime_from_unix_time(time[key])
				var dateString = ""
				match settings.get_date_format():
					settings.DATE_FORMAT.DDMMYYYY:
						dateString += str(newTime["day"]) + "/" 
						dateString += str(newTime["month"]) + "/"
					settings.DATE_FORMAT.MMDDYYYY:
						dateString += str(newTime["month"]) + "/"
						dateString += str(newTime["day"]) + "/" 
						
				dateString += str(newTime["year"]) + " " 
				dateString += str(newTime["hour"]) + ":" 
				dateString += str(newTime["minute"]) 
				line.append(dateString)
			elif key == "Time Worked":
				var timeWorked = time["signOut"] - time["signIn"]
				print(timeWorked)
				timeWorked = timeWorked/(60.0 * 60.0)
				timeWorked *= 10000
				timeWorked = round(timeWorked)
				timeWorked /= 10000.0
				print(timeWorked)
				line.append(timeWorked)
			else:
				line.append(time[key])
		
		file.store_csv_line(line)
	
	file.close()