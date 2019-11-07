extends Control

signal update_list()

var update_list_open = false
var time_log_open = false
var report_log_open = false
var settings_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	settings.load_settings(self)
	if not settings.get_first_run():
		$SetupScene.queue_free()
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
	if not update_list_open:
		var updateList = load("res://Scenes/UpdateEmployeeList/UpdateList.tscn")
		add_child(updateList.instance())
		update_list_open = true
	pass # Replace with function body.


func _on_Control_gen_single_report():
	if not report_log_open:
		var single_report = load("res://Scenes/ReportEmployeeList/ReportList.tscn")
		add_child(single_report.instance())
		report_log_open = true
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
	var complete = FileManager.generate_all_employee_files(file_loc, start, end, simple)
	
	var confirm = load("res://Scenes/HelperScenes/FileCreated.tscn")
	var temp = confirm.instance()
	temp.set_text(complete)
	add_child(temp)
	
	pass


func _on_Control_open_settings():
	if not settings_open:
		var settingScene = load("res://Scenes/Settings/SidePanel.tscn")
		var settingPanel = settingScene.instance()
		add_child(settingPanel)
		settings_open = true
		pass # Replace with function body.


func _on_Control_view_time_log():
	if not time_log_open:
		var timeLogList = load("res://Scenes/ReportEmployeeList/ReportList.tscn")
		var panel = timeLogList.instance()
		panel.set_to_timelog()
		add_child(panel)
		time_log_open = true


func _on_Button_pressed():
	settings.delete_files()
	pass # Replace with function body.
