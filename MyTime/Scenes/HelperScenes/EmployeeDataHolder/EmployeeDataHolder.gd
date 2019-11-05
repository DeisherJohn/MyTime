extends Control

enum button_type {SIGN_IN = 0, SIGN_OUT = 1, UPDATE = 2, REPORT = 3}

export(button_type) var button_mode : int

signal update_button_text(text)
signal update_data(employee)
signal button_press(employee)

var _employee = null

func _ready():
#	set_button_text()
#	set_data(dbManager.getEmployee(1000))
	pass

func set_button_text(mode = 0):
	button_mode = mode
	match button_mode:
		button_type.SIGN_IN:
			emit_signal("update_button_text", "Sign In")
		button_type.SIGN_OUT:
			emit_signal("update_button_text", "Sign Out")
		button_type.UPDATE:
			emit_signal("update_button_text", "Select")
		button_type.REPORT:
			emit_signal("update_button_text", "Select")
			
func set_data(employee):
	if employee == null: return
	_employee = employee
	emit_signal("update_data", employee)

func _on_Button_pressed():
	
	emit_signal("button_press", _employee)
			
	pass # Replace with function body.

func set_connect(target):
	connect("button_press", target, "employee_selected")
	
	
	
	
	
	
	