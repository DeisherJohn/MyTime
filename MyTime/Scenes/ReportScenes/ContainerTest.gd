extends Control

var _employee = null
var start_date = 0
var end_date = null

var cards = preload("res://Scenes/ReportScenes/ReportButton.tscn")

var Grid = null

func _ready():
	_employee = dbManager.getEmployee(1000)
	Grid = $PanelContainer/VBoxContainer/ScrollContainer/GridContainer
	fill_data()

func set_employee(employee):
	_employee = employee
	
func get_employee():
	return _employee
	

func set_date_range(start, end):
	start_date = start
	end_date = end

func edit_time(time):
	fill_time_entry(time)
	$WindowDialog.popup_centered()
	pass

func fill_data():
	if Grid.get_children() != null:
		for child in Grid.get_children():
			child.queue_free()
	
	if _employee == null:
		return
		
	var shifts = dbManager.getShiftTimes(_employee["eid"], start_date, end_date, 100)
	var time_worked = 0.0
	
	for shift in shifts:
		var card = cards.instance()
		card.set_time_record(shift)
		time_worked += card.get_time_worked()
		Grid.add_child(card)
		card.connect_time_sig(self)
	
	$PanelContainer/VBoxContainer/LabelEmpName.set_text(_employee["first_name"] + " " + _employee["last_name"])
	$PanelContainer/VBoxContainer/HBoxContainer/TimeWorked.set_text(str(time_worked))
	
	
func fill_time_entry(time_log):
	if time_log == null:
		return
	
	$WindowDialog/MarginContainer/VBoxContainer/HBoxContainer/LineID.set_text(str(time_log["id"]))
	
	$WindowDialog/MarginContainer/VBoxContainer/SignInDate.set_date(time_log)
	var time = OS.get_datetime_from_unix_time(time_log["signIn"])
	$WindowDialog/MarginContainer/VBoxContainer/HBoxContainer2/SignInHour.set_text(str(time["hour"]))
	$WindowDialog/MarginContainer/VBoxContainer/HBoxContainer2/SignInMin.set_text(str(time["minute"]))
	
	$WindowDialog/MarginContainer/VBoxContainer/SignOutDate.set_date(time_log)
	time = OS.get_datetime_from_unix_time(time_log["signOut"])
	$WindowDialog/MarginContainer/VBoxContainer/HBoxContainer3/SignOutHour.set_text(str(time["hour"]))
	$WindowDialog/MarginContainer/VBoxContainer/HBoxContainer3/SignOutMin.set_text(str(time["minute"]))
	
	var time_worked = FileManager.get_time_between_shifts(time_log["signIn"], time_log["signOut"])
	
	$WindowDialog/MarginContainer/VBoxContainer/HBoxContainer4/TimeWorked.set_text(str(time_worked))
	
	
	
	

func _on_ButtonCancel_pressed():
	$WindowDialog/MarginContainer/VBoxContainer/HBoxContainer6/lineAdminPin.set_text("")
	$WindowDialog.hide()
	pass # Replace with function body.


func _on_ButtonAcceptTimeUpdate_pressed():
	var enteredPin = $WindowDialog/MarginContainer/VBoxContainer/HBoxContainer6/lineAdminPin.get_text()
	$WindowDialog/MarginContainer/VBoxContainer/HBoxContainer6/lineAdminPin.set_text("")
	
	if enteredPin != settings.get_admin_pin():
		return
	
	
	var id = $WindowDialog/MarginContainer/VBoxContainer/HBoxContainer/LineID.get_text()
	
	var SID = $WindowDialog/MarginContainer/VBoxContainer/SignInDate.get_date()
	var SIH = int($WindowDialog/MarginContainer/VBoxContainer/HBoxContainer2/SignInHour.get_text())
	var SIM = int($WindowDialog/MarginContainer/VBoxContainer/HBoxContainer2/SignInMin.get_text())
	
	SID = OS.get_unix_time_from_datetime(SID)
	
	SID += (SIH * 60 * 60) + (SIM * 60)
	
	var SOD = $WindowDialog/MarginContainer/VBoxContainer/SignOutDate.get_date()
	var SOH = int($WindowDialog/MarginContainer/VBoxContainer/HBoxContainer3/SignOutHour.get_text())
	var SOM = int($WindowDialog/MarginContainer/VBoxContainer/HBoxContainer3/SignOutMin.get_text())
	
	SOD = OS.get_unix_time_from_datetime(SOD)
	
	SOD += (SOH * 60 * 60) + (SOM * 60)
	
	dbManager.update_time_entry(_employee["eid"], id, SID, SOD)
	
	$WindowDialog.hide()
	fill_data()
	
	pass # Replace with function body.


func _on_WindowDialog_hide():
	$WindowDialog/MarginContainer/VBoxContainer/HBoxContainer6/lineAdminPin.set_text("")
	pass # Replace with function body.


func _on_ButtonClose_pressed():
	queue_free()
	pass # Replace with function body.
