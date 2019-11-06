extends Control

var timeLog = preload("res://Scenes/ReportScenes/ReportTimeLog.tscn")
var datePicker = preload("res://Scenes/HelperScenes/FileSave.tscn")

var selected_employee = null
var _start = null
var _end = null

func _on_Button_pressed():
	get_parent().update_employee_list()
	queue_free()
	pass # Replace with function body.

func set_to_timelog():
	$Panel/MarginContainer/VBoxContainer/ListHolder.list_type = $Panel/MarginContainer/VBoxContainer/ListHolder.BUTTON_TYPE.TIMELOG

func _on_ListHolder_load_time(employee, start, end):
	selected_employee = employee
	_start = start
	_end = end
	
	var date = datePicker.instance()
	date.date_only()
	get_parent().add_child(date)
	date.connect_sig(self)
	
	
	pass # Replace with function body.

func make_file(file_loc, start = 0, end = null, simple = true):
	var TimeList = timeLog.instance()
	get_parent().add_child(TimeList)
	TimeList.set_employee(selected_employee)
	TimeList.set_date_range(start,end)
	TimeList.fill_data()