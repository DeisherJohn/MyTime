extends Control

func _ready():
	pass


func _on_Button_pressed():
	get_parent().update_employee_list()
	queue_free()
	pass # Replace with function body.
