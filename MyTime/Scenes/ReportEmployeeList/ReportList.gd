extends Control

var timeLog = preload("res://Scenes/ReportScenes/ReportTimeLog.tscn")


func _on_Button_pressed():
	get_parent().update_employee_list()
	queue_free()
	pass # Replace with function body.

func set_to_timelog():
	$Panel/MarginContainer/VBoxContainer/ListHolder.list_type = $Panel/MarginContainer/VBoxContainer/ListHolder.BUTTON_TYPE.TIMELOG

func _on_ListHolder_load_time(employee, start, end):
	
	var TimeList = timeLog.instance()
	get_parent().add_child(TimeList)
	TimeList.set_employee(employee)
	TimeList.set_date_range(0,null)
	TimeList.fill_data()
	pass # Replace with function body.
