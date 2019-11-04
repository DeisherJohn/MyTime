extends Node

const DEFAULT_FILE_LOC = "res://Reports/"

func _ready():
	var emp = Dictionary()
	emp["eid"] =1000
	generate_single_csv(emp)
	
	pass
	
func generate_single_csv(employee, file_loc = null, start = 0, end = null):
	var get_times = dbManager.getShiftTimes(employee["eid"], start, end)
	
	if len(get_times) < 1:
		return false
	
	if file_loc == null:
		file_loc = DEFAULT_FILE_LOC + str(OS.get_unix_time()) + ".csv"
		
	var keys = get_times[0].keys()
	
	var file = File.new()
	
	file.open(file_loc, file.WRITE)
	
	file.store_csv_line(keys)
	
	for time in get_times:
		var line = PoolStringArray()
		for key in keys:
			if key == "signIn" or key == "signOut":
				time[key] = OS.get_datetime_from_unix_time(time[key])
				print(time[key])
				var dateString = ""
				match settings.get_date_format():
					settings.DATE_FORMAT.DDMMYYYY:
						dateString += str(time[key]["day"]) + "/" 
						dateString += str(time[key]["month"]) + "/"
					settings.DATE_FORMAT.MMDDYYYY:
						dateString += str(time[key]["month"]) + "/"
						dateString += str(time[key]["day"]) + "/" 
						
				dateString += str(time[key]["year"]) + " " 
				dateString += str(time[key]["hour"]) + ":" 
				dateString += str(time[key]["minute"]) + ":" 
				line.append(dateString)
			else:
				line.append(time[key])
		
		file.store_csv_line(line)
	
	file.close()