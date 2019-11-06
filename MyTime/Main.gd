extends Control

signal update_list()

# Called when the node enters the scene tree for the first time.
func _ready():
	settings.load_settings(self)
	pass # Replace with function body.



func _on_Control_add_new_employee():
	var employee_panel = load("res://Scenes/EmployeeData/EmployeeData.tscn")
	var new_emp = employee_panel.instance()
	new_emp.connect_update_list(self)
	add_child(new_emp)
	pass # Replace with function body.


func kill(obj):
	obj.queue_free()


func update_employee_list():
	emit_signal("update_list")
	pass

func _on_Control_update_employees():
	var updateList = load("res://Scenes/UpdateEmployeeList/UpdateList.tscn")
	add_child(updateList.instance())
	pass # Replace with function body.


func _on_Control_gen_single_report():
	var single_report = load("res://Scenes/ReportEmployeeList/ReportList.tscn")
	add_child(single_report.instance())
	pass # Replace with function body.


func _on_Control_gen_all_report():
	var all_report = load("res://Scenes/HelperScenes/FileSave.tscn")
	var file = all_report.instance()
	add_child(file)
	file.connect_sig(self)
	pass # Replace with function body.


func make_file(file_loc, start = 0, end = null, simple = true):
	if file_loc == null:
		return
	FileManager.generate_all_employee_files(file_loc, start, end, simple)
	pass


func _on_Control_open_settings():
	var settingScene = load("res://Scenes/Settings/SidePanel.tscn")
	var settingPanel = settingScene.instance()
	add_child(settingPanel)
	pass # Replace with function body.


func _on_Control_view_time_log():
	var timeLogList = load("res://Scenes/ReportEmployeeList/ReportList.tscn")
	var panel = timeLogList.instance()
	panel.set_to_timelog()
	add_child(panel)
