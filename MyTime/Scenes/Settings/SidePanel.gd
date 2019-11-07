extends Control


onready var MM = $PanelContainer/VBoxContainer/HBoxContainer/HBoxContainer/CheckBoxMM
onready var DD = $PanelContainer/VBoxContainer/HBoxContainer/HBoxContainer/CheckBoxDD
onready var filePath = $PanelContainer/VBoxContainer/VBoxContainer/LabelFilePath


func _ready():
	filePath.set_text(str(settings.get_save_location()))
	
	match settings.get_date_format():
		settings.DATE_FORMAT.MMDDYYYY:
			MM.set_pressed(true)
			DD.set_pressed(false)
		settings.DATE_FORMAT.DDMMYYYY:
			MM.set_pressed(false)
			DD.set_pressed(true)
	pass


func _on_ButtonSave_pressed():
	
	if DD.is_pressed():
		settings.set_date_format(settings.DATE_FORMAT.DDMMYYYY)
	else:
		settings.set_date_format(settings.DATE_FORMAT.MMDDYYYY)
		
	settings.set_save_location(filePath.get_text())
	
	settings.save_settings()
	queue_free()


func _on_ButtonCancel_pressed():
	get_parent().settings_open = false
	queue_free()


func _on_CheckBoxDD_toggled(button_pressed):
	if button_pressed:
		MM.set_pressed(false)
	pass # Replace with function body.


func _on_CheckBoxMM_toggled(button_pressed):
	if button_pressed:
		DD.set_pressed(false)
	pass # Replace with function body.


func _on_Button_pressed():
	$FileDialog.set_current_path(filePath.get_text())
	$FileDialog.popup()
	pass # Replace with function body.


func _on_FileDialog_dir_selected(dir):
	filePath.set_text(dir + "/")
	pass # Replace with function body.


func _on_FileDialog_file_selected(path):
	print(path)
	pass # Replace with function body.


func _on_ButtonAbout_pressed():
	$AboutWindow.show_window()
	pass # Replace with function body.
