extends WindowDialog


onready var MM = $PanelContainer/VBoxContainer/HBoxContainer/HBoxContainer/CheckBoxMM
onready var DD = $PanelContainer/VBoxContainer/HBoxContainer/HBoxContainer/CheckBoxDD
onready var filePath = $PanelContainer/VBoxContainer/VBoxContainer/LabelFilePath
onready var hhmm_full = $PanelContainer/VBoxContainer/HBoxContainer3/HBoxContainer/CheckHHmm_full
onready var hhmm_dec = $PanelContainer/VBoxContainer/HBoxContainer3/HBoxContainer/CheckHHmm_dec



func _ready():
	filePath.set_text(str(settings.get_save_location()))
	
	match settings.get_date_format():
		settings.DATE_FORMAT.MMDDYYYY:
			MM.set_pressed(true)
			DD.set_pressed(false)
		settings.DATE_FORMAT.DDMMYYYY:
			MM.set_pressed(false)
			DD.set_pressed(true)
	
	if settings.get_hr_mm():
		hhmm_full.set_pressed(true)
		hhmm_dec.set_pressed(false)
	else:
		hhmm_full.set_pressed(false)
		hhmm_dec.set_pressed(true)
	
	
	pass

func show_center():
	self.popup_centered()

func _on_ButtonSave_pressed():
	
	if DD.is_pressed():
		settings.set_date_format(settings.DATE_FORMAT.DDMMYYYY)
	else:
		settings.set_date_format(settings.DATE_FORMAT.MMDDYYYY)
	
	if hhmm_dec.is_pressed():
		settings.set_hr_mm_format(false)
	else:
		settings.set_hr_mm_format(true)
		
	settings.set_save_location(filePath.get_text())
	
	settings.save_settings()
	self.hide()


func _on_ButtonCancel_pressed():
	self.hide()


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

	pass # Replace with function body.



func _on_CheckHHmm_full_toggled(button_pressed):
	if button_pressed:
		hhmm_dec.set_pressed(false)


func _on_CheckHHmm_dec_toggled(button_pressed):
	if button_pressed:
		hhmm_full.set_pressed(false)


func _on_ButtonCancel_toggled(button_pressed):
	pass # Replace with function body.
