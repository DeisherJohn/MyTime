extends Control

signal add_new_employee()

func _on_Button_pressed():
	emit_signal("add_new_employee")
	pass # Replace with function body.
