extends Control

signal add_new_employee()
signal update_employees()
signal gen_single_report()
signal gen_all_report()

func _on_Button_pressed():
	emit_signal("add_new_employee")
	pass # Replace with function body.


func _on_Button2_pressed():
	emit_signal("update_employees")
	pass # Replace with function body.
	

func _on_Button3_pressed():
	emit_signal("gen_single_report")
	pass # Replace with function body.


func _on_Button4_pressed():
	emit_signal("gen_all_report")
	pass # Replace with function body.
