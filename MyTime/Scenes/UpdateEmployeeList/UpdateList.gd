extends Control

func _ready():
	pass


func _on_Button_pressed():
	get_parent().update_employee_list()
	if $Panel/MarginContainer/VBoxContainer/ListHolder.list_type == $Panel/MarginContainer/VBoxContainer/ListHolder.BUTTON_TYPE.UPDATE:
		get_parent().update_list_open = false
	elif $Panel/MarginContainer/VBoxContainer/ListHolder.list_type == $Panel/MarginContainer/VBoxContainer/ListHolder.BUTTON_TYPE.TIMELOG:
		get_parent().time_log_open = false
	elif $Panel/MarginContainer/VBoxContainer/ListHolder.list_type == $Panel/MarginContainer/VBoxContainer/ListHolder.BUTTON_TYPE.REPORT:
		get_parent().report_log_open = false
		pass
		
	queue_free()
	pass # Replace with function body.


func set_to_timelog():
	$Panel/MarginContainer/VBoxContainer/ListHolder.list_type = $Panel/MarginContainer/VBoxContainer/ListHolder.BUTTON_TYPE.TIMELOG


