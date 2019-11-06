extends Control

signal file_loc(path, start, end)

var confirmed = false
var file_path = null

onready var start = $WindowDialog/MarginContainer/VBoxContainer/StartDate
onready var end = $WindowDialog/MarginContainer/VBoxContainer/EndDate
onready var simpleReport = $WindowDialog/MarginContainer/VBoxContainer/CheckBox

func _ready():
	$FileDialog.popup_centered()
	$FileDialog.set_current_path(settings.get_save_location())
	pass


func connect_sig(target):
	var error = connect("file_loc", target, "make_file")
	if error: print("ERR: %s" % error)
	
func _on_FileDialog_file_selected(path):
	confirmed = true
	
	if ".csv" in path:
		file_path = path
	else:
		path += ".csv"
		file_path = path
	$WindowDialog.popup_centered()
	pass # Replace with function body.


func _on_FileDialog_popup_hide():
	$FileDialog.queue_free()
	
	if not confirmed:
		emit_signal("file_loc", null)
		queue_free()
	pass # Replace with function body.
	
func roll_date_back(days):
	var last_day = end.get_date()
	
	last_day = OS.get_unix_time_from_datetime(last_day) - (days * 24 * 60 * 60) # times hours, minutes, seconds
	var temp = Dictionary()
	temp["startDate"] = last_day
	start.set_date(temp)
	
	


func _on_Button_pressed():
	roll_date_back(1)
	pass # Replace with function body.


func _on_Button2_pressed():
	roll_date_back(7)
	pass # Replace with function body.


func _on_Button3_pressed():
	roll_date_back(14)
	pass # Replace with function body.


func _on_Button4_pressed():
	roll_date_back(28)
	pass # Replace with function body.


func _on_ButtonAccept_pressed():
	var startDate = start.get_date()
	var endDate = end.get_date()
	
	endDate["hour"] = 23
	endDate["minute"] = 59
	endDate["second"] = 59
	startDate = OS.get_unix_time_from_datetime(startDate)
	endDate = OS.get_unix_time_from_datetime(endDate)
	
	emit_signal("file_loc", file_path, startDate , endDate, simpleReport.is_pressed())
	queue_free()
	pass # Replace with function body.


func _on_ButtonCancel_pressed():
	emit_signal("file_loc", null)
	queue_free()
	pass # Replace with function body.
