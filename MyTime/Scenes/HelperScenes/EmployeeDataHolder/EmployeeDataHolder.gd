extends Control

enum button_type {SIGN_IN = 0, SIGN_OUT = 1, UPDATE = 2, REPORT = 3, TIMELOG}

export(button_type) var button_mode : int

signal update_button_text(text)
signal update_data(employee)
signal button_press(employee)

var _employee = null

var pin = null
var override_pin = false

var style = StyleBoxFlat.new()
var bgColor = Color(0)
var colorPicker = null

func _ready():
	colorPicker = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/HBoxContainer3/ColorPickerButton
	$Panel.add_stylebox_override("panel", style)
	style.set_border_color(Color(0,0,0))
	style.set_border_width_all(3)
	style.set_corner_radius_all(4)
	style.set_border_blend(true)
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
		button_type.TIMELOG:
			emit_signal("update_button_text", "Select")
		_:
			emit_signal("update_button_text", "Select")


func set_data(employee):
	if employee == null: return
	_employee = employee
	emit_signal("update_data", employee)
	bgColor = settings.get_employee_color(_employee["eid"])
	style.set_bg_color(bgColor)


func _on_Button_pressed():
	if (pin == _employee["pin"] and button_mode != button_type.REPORT) or pin == settings.get_admin_pin() or override_pin:
		settings.set_employee_color(_employee["eid"], bgColor)
		emit_signal("button_press", _employee)		
		pin = null


func set_connect(target):
	var error = connect("button_press", target, "employee_selected")
	if error: print("ERR: %s" % error)


func _on_LineEdit_text_changed(new_text):
	pin = new_text


func _on_LineEdit_text_entered(new_text):
	pin = new_text
	_on_Button_pressed()
	pass # Replace with function body.


func _on_ColorPickerButton_color_changed(color):
	bgColor = color
	$Panel.get_stylebox("panel", "").set_bg_color(bgColor)
	pass # Replace with function body.


func _on_ColorPickerButton_popup_closed():
	$Panel.get_stylebox("panel", "").set_bg_color(bgColor)
	settings.set_employee_color(_employee["eid"], bgColor)
	pass # Replace with function body.
	
func set_override_pin(value):
	override_pin = value
