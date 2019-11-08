extends Control


onready var info = $WindowDialog/MarginContainer/VBoxContainer

onready var pin1 = info.get_node("LinePinOne").get_text()
onready var pin2 = info.get_node("LinePinTwo").get_text()

func show_win():
	$WindowDialog.show()


func _on_Button_pressed():
	if pin1.is_valid_integer():
		settings.set_admin_pin(pin1)
		settings.save_settings()
		self.queue_free()
	pass # Replace with function body.


func _on_LinePinOne_text_changed(new_text):
	pin1 = new_text
	pins_match()


func _on_LinePinTwo_text_changed(new_text):
	pin2 = new_text
	pins_match()

func pins_match():
	if pin1 == pin2 and len(pin1) == 4 and pin1.is_valid_integer():
		info.get_node("Label3").hide()
		info.get_node("Button").disabled = false
	else:
		info.get_node("Label3").show()
		info.get_node("Button").disabled = true