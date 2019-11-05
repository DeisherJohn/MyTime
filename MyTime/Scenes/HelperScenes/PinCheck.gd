extends PanelContainer

signal pin_check(pin)

var employee_pin = null
var admin_override = false

func _ready():
	pass

func pass_pin(employee):
	employee_pin = employee["pin"]
	
func _on_ButtonCancel_pressed():
	emit_signal("pin_check", false)
	queue_free()
	pass # Replace with function body.


func _on_ButtonEnter_pressed():
	if admin_override:
		if $VBoxContainer/LineEdit.get_text() == settings.get_admin_pin():
			emit_signal("pin_check", true)
		else:
			emit_signal("pin_check", false)
	elif $VBoxContainer/LineEdit.get_text() == employee_pin:
		emit_signal("pin_check", true)
	else:
		emit_signal("pin_check", false)
	queue_free()
	pass # Replace with function body.


func _on_CheckBox_toggled(button_pressed):
	admin_override = button_pressed
	pass # Replace with function body.

func connect_signal(target):
	var error = connect("pin_check", target, "check_clear")
	if error: print("ERR: %s" % error)