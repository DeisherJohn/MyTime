extends Control

signal update_list()

# Called when the node enters the scene tree for the first time.
func _ready():
	print("MAIN WINDOW")
	settings.load_settings(self)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Control_add_new_employee():
	var employee_panel = load("res://Scenes/EmployeeData/EmployeeData.tscn")
	var new_emp = employee_panel.instance()
	add_child(new_emp)
	pass # Replace with function body.

func kill(obj):
	obj.queue_free()
	
func update_employee_list():
	emit_signal("update_list")
	pass