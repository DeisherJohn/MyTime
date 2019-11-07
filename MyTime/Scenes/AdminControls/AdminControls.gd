extends Control

signal add_new_employee()
signal update_employees()
signal gen_single_report()
signal gen_all_report()
signal open_settings()
signal view_time_log()

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
	if $PanelContainer/VBoxContainer/HBoxContainer/LineEdit.get_text() == settings.get_admin_pin():
		emit_signal("gen_all_report")
	
	$PanelContainer/VBoxContainer/HBoxContainer/LineEdit.set_text("")
	pass # Replace with function body.


func _on_Button5_pressed():
	if $PanelContainer/VBoxContainer/HBoxContainer2/LineEdit2.get_text() == settings.get_admin_pin():
		emit_signal("open_settings")
	
	$PanelContainer/VBoxContainer/HBoxContainer2/LineEdit2.set_text("")
	
	pass # Replace with function body.


func _on_Button6_pressed():
	emit_signal("view_time_log")
	pass # Replace with function body.


func _on_LineEdit_text_entered(new_text):
	if new_text == settings.get_admin_pin():
		emit_signal("gen_all_report")
	
	$PanelContainer/VBoxContainer/HBoxContainer/LineEdit.set_text("")


func _on_LineEdit2_text_entered(new_text):
	if new_text == settings.get_admin_pin():
		emit_signal("open_settings")
	
	$PanelContainer/VBoxContainer/HBoxContainer2/LineEdit2.set_text("")
	pass # Replace with function body.


func _on_Button7_pressed():
	$AboutWindow.show_window()
	pass # Replace with function body.
