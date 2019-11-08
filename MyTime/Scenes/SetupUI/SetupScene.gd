extends Control

onready var db_path = $Popup/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/LineDBPath
onready var report_path = $Popup/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/LineReport
onready var checkMM = $Popup/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer4/VBoxContainer/CheckBoxMM
onready var checkDD = $Popup/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer4/VBoxContainer/CheckBoxDD

var pin1 = null
var pin2 = null

func _ready():
	$Popup.popup_centered()
	db_path.set_text(settings.get_db_location()) 
	report_path.set_text(settings.get_save_location())
	
	if settings.get_date_format() == settings.DATE_FORMAT.MMDDYYYY:
		checkMM.set_pressed(true)
		checkDD.set_pressed(false)
	else:
		checkMM.set_pressed(false)
		checkDD.set_pressed(true)



func _on_CheckBoxMM_toggled(button_pressed):
	if button_pressed:
		checkDD.set_pressed(false)


func _on_CheckBoxDD_toggled(button_pressed):
	if button_pressed:
		checkMM.set_pressed(false)


func _on_ButtonDBBrowse_pressed():
	$FileDialogDB.popup_centered()
	$FileDialogDB.set_current_dir(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS))
	pass # Replace with function body.


func _on_ButtonReset_pressed():
	db_path.set_text(settings.get_db_location())
	pass # Replace with function body.


func _on_FileDialogDB_dir_selected(dir):
	db_path.set_text(dir)
	pass # Replace with function body.


func _on_ButtonReportBrowse_pressed():
	$FileDialogReport.popup_centered()
	$FileDialogReport.set_current_dir(report_path.get_text())
	pass # Replace with function body.


func _on_FileDialogReport_dir_selected(dir):
	report_path.set_text(dir)
	pass # Replace with function body.


func _on_LineEditAdmin1_text_changed(new_text):
	pin1 = new_text
	match_pins()

func _on_LineEditAdmin2_text_changed(new_text):
	pin2 = new_text
	match_pins()


func match_pins():
	if pin1.is_valid_integer() and len(pin1) == 4 and pin1 == pin2:
		$Popup/PanelContainer/MarginContainer/VBoxContainer/ButtonAccept.set_disabled(false)
	else:
		$Popup/PanelContainer/MarginContainer/VBoxContainer/ButtonAccept.set_disabled(true)


func _on_ButtonAccept_pressed():
	
	settings.set_db_location(db_path.get_text())
	settings.set_save_location(report_path.get_text())
	
	var format = settings.DATE_FORMAT.DDMMYYYY if checkDD.is_pressed() else settings.DATE_FORMAT.MMDDYYYY
	settings.set_date_format(format)
	
	settings.set_admin_pin(pin1)
	settings.set_first_run(false)
	
	settings.save_settings()
	dbManager.make_db()
	queue_free()
	
	pass # Replace with function body.
