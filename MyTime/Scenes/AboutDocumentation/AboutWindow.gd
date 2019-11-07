extends Control

func show_window():
	$WindowDialog.popup_centered()
	pass


func _on_Button_pressed():
	$WindowDialog.hide()
	pass # Replace with function body.
