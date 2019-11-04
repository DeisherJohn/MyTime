extends Control

signal add_new_employee()
signal update_employees()

func _on_Button_pressed():
	emit_signal("add_new_employee")
	pass # Replace with function body.


func _on_Button2_pressed():
	emit_signal("update_employees")
	pass # Replace with function body.
