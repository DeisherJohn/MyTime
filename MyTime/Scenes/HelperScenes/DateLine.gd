extends Control

export var date_title : String = "Date"
export var key : String = "date"
export var key_to_pull : String = "startDate"


var day = null
var month = null

func _ready():
	
	$HBoxContainer/Label.set_text(date_title)
	
	match settings.get_date_format():
		settings.DATE_FORMAT.MMDDYYYY:
			#US Date
			$HBoxContainer/LineEdit.set_placeholder("mm")
			$HBoxContainer/LineEdit.set_tooltip("Month")
			$HBoxContainer/LineEdit2.set_placeholder("dd")
			$HBoxContainer/LineEdit2.set_tooltip("Day")
			
			day = $HBoxContainer/LineEdit2
			month = $HBoxContainer/LineEdit
			
		settings.DATE_FORMAT.DDMMYYYY:
			$HBoxContainer/LineEdit.set_placeholder("dd")
			$HBoxContainer/LineEdit.set_tooltip("Day")
			$HBoxContainer/LineEdit2.set_placeholder("mm")
			$HBoxContainer/LineEdit2.set_tooltip("Month")
			
			day = $HBoxContainer/LineEdit
			month = $HBoxContainer/LineEdit2


func set_date(date = null):
	if date == null:
		date = OS.get_date()
	else:
		date = OS.get_datetime_from_unix_time(int(date[key_to_pull]))
	
	day.set_text(str(date["day"]))
	month.set_text(str(date["month"]))
		
	$HBoxContainer/LineEdit3.set_text(str(date["year"]))


func _on_Button_pressed():
	set_date()


func get_date():
	var date = Dictionary()
	date["day"] = day.get_text()
	date["month"] = month.get_text()
	date["year"] = $HBoxContainer/LineEdit3.get_text()
	
	return date
	
func get_data():
	var date = Dictionary()
	date[key] = get_date()
	
	return date
