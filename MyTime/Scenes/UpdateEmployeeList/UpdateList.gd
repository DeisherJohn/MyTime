extends Control

func _ready():
	pass


func _on_Button_pressed():
	get_parent().update_employee_list()
	queue_free()
	pass # Replace with function body.


func set_to_timelog():
	$Panel/MarginContainer/VBoxContainer/ListHolder.list_type = $Panel/MarginContainer/VBoxContainer/ListHolder.BUTTON_TYPE.TIMELOG