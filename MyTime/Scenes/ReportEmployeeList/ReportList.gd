extends Control

var timeLog = preload("res://Scenes/ReportScenes/ReportTimeLog.tscn")
var datePicker = preload("res://Scenes/HelperScenes/FileSave.tscn")

var selected_employee = null
var _start = null
var _end = null

onready var list = $Panel/MarginContainer/VBoxContainer/ListHolder

func _on_Button_pressed():
	get_parent().update_employee_list()
	
	match list.list_type:
		list.BUTTON_TYPE.REPORT:
			get_parent().report_log_open = false
		list.BUTTON_TYPE.TIMELOG:
			get_parent().time_log_open = false
		_:
			pass
	queue_free()
	pass # Replace with function body.

func set_to_timelog():
	$Panel/MarginContainer/VBoxContainer/ListHolder.list_type = $Panel/MarginContainer/VBoxContainer/ListHolder.BUTTON_TYPE.TIMELOG

func _on_ListHolder_load_time(employee):
	selected_employee = employee
	_start = 0
	_end = null
	
	var date = datePicker.instance()
	date.make_date_only()
	get_parent().add_child(date)
	date.connect("dates_selected", self, "show_time_log")
	
	
	pass # Replace with function body.

func show_time_log(start, end):
	if start == null and end == null:
		return
		
	var TimeList = timeLog.instance()
	get_parent().add_child(TimeList)
	TimeList.set_employee(selected_employee)
	TimeList.set_date_range(start,end)
	TimeList.fill_data()
	pass
	