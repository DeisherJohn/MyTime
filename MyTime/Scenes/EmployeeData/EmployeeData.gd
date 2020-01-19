extends Control

export var update_employee : bool

signal set_data(employee)
signal update_list()

var eid = null

func _ready():
	$WindowDialog.popup_centered()
#	set_data(dbManager.getEmployee(1000))

func connect_update_list(target):
	var error = connect("update_list", target, "update_employee_list")
	if error != OK:
		print("ERROR CONNECTING SIG: %s" % error)
	
func set_to_update():
	update_employee = true
	$WindowDialog/MarginContainer/VBoxContainer2/Button.set_text("Update Employee")
	
	
func pull_data():
	var employee = Dictionary()
	
	for child in $WindowDialog/MarginContainer/VBoxContainer2/VBoxContainer.get_children():
		var temp = child.get_data()
		
		if temp == null: return null
		
		for key in temp.keys():
			employee[key] = temp[key]
	
	employee["eid"] = eid
	return employee
	
func set_data(employee):
	emit_signal("set_data", employee)
	eid = employee["eid"]
	pass

func _on_Button_pressed():
	var admin_pin = $WindowDialog/MarginContainer/VBoxContainer2/AdminPin.get_data() 
	if admin_pin == null: return
	
	var employee = null
	
	if admin_pin["pin"] == settings.get_admin_pin():
		employee = pull_data()
		var newDate = OS.get_date()
		newDate["day"] = employee["startDate"]["day"]
		newDate["month"] = employee["startDate"]["month"]
		newDate["year"] = employee["startDate"]["year"]
		employee["startDate"] = OS.get_unix_time_from_datetime(newDate)
	
	if employee == null:
		print("Employee was missing data")
	else:
		if update_employee:
			dbManager.updateEmployee(employee)
		else:
			dbManager.addEmployee(employee) 
			
		emit_signal("update_list")
		
	queue_free()
	pass # Replace with function body.
	


func _on_WindowDialog_popup_hide():
	self.queue_free()
	pass # Replace with function body.

