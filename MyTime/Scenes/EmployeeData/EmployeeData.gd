extends Control

export var update_employee : bool

func _ready():
	
	if update_employee:
		$WindowDialog/MarginContainer/VBoxContainer2/Button.set_text("Update Employee")
	$WindowDialog.popup_centered()
	
	
func pull_data():
	var employee = Dictionary()
	
	for child in $WindowDialog/MarginContainer/VBoxContainer2/VBoxContainer.get_children():
		var temp = child.get_data()
		
		if temp == null: return null
		
		for key in temp.keys():
			employee[key] = temp[key]
			
	return employee

func _on_Button_pressed():
	var admin_pin = $WindowDialog/MarginContainer/VBoxContainer2/AdminPin.get_data() 
	var employee = null
	if admin_pin["pin"] == settings.get_admin_pin():
		employee = pull_data()
		var newDate = OS.get_date()
		newDate["day"] = employee["startDate"]["day"]
		newDate["month"] = employee["startDate"]["month"]
		newDate["year"] = employee["startDate"]["year"]
		employee["startDate"] = OS.get_unix_time_from_datetime(newDate)
		print(employee)
	
	if employee == null:
		print("Employee was missing data")
	else:
		dbManager.addEmployee(employee) 
		get_parent().update_employee_list()
		
	queue_free()
	pass # Replace with function body.
	


func _on_WindowDialog_popup_hide():
	self.queue_free()
	pass # Replace with function body.

