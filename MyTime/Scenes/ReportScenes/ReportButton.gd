extends Control

export(bool) var header

signal selected_time(time)
var time_record = null
var time_worked = 0.0

func _ready():
	if header:
		set_as_header()
	pass

func set_time_record(data):
	time_record = data
	time_worked = FileManager.get_time_between_shifts(time_record["signIn"], time_record["signOut"])
	$HBoxContainer/labelID.set_text(str(time_record["id"]))
	$HBoxContainer/labelSignIn.set_text(FileManager.convert_unixtime_to_string_time(time_record["signIn"]))
	$HBoxContainer/labelSignOut.set_text(FileManager.convert_unixtime_to_string_time(time_record["signOut"]))
	$HBoxContainer/labelTimeWorked.set_text(str(time_worked))
	pass

func connect_time_sig(target):
	self.connect("selected_time", target, "edit_time")
	
	
func get_time_worked():
	return time_worked
	
func _on_Button_pressed():
	emit_signal("selected_time", time_record)
	pass # Replace with function body.

func set_as_header():
	$Button.set_disabled(true)
	$HBoxContainer/labelID.set_text("ID")
	$HBoxContainer/labelSignIn.set_text("Time Signed In")
	$HBoxContainer/labelSignOut.set_text("Time Signed Out")
	$HBoxContainer/labelTimeWorked.set_text("Hours Worked")