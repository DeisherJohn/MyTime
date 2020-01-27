extends Node

const SAVE_PATH = "user://config.cfg"

enum DATE_FORMAT {MMDDYYYY = 0, DDMMYYYY = 1}

var _config_file = ConfigFile.new()

const DEF_COLOR = Color(0.335938,0.335938,0.335938,1)

var _settings = {
	"hidden":{
		"admin_pin":"0000",
		"first_run":true,
		"version":"0.1.3"
	},
	"date":{
		"format":DATE_FORMAT.MMDDYYYY,
		"hr_mm_format":true
	},
	"files":{
		"save_location":OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS) + "\\",
		"database_location":"user://data.sql"
	},
	"color":{
		
	}
}

func _ready():
	var error = load_settings()
	
	if error == OK:
		#First run
		print("Save file did not open, ERROR: %s" %error)
		 
	OS.set_low_processor_usage_mode(true) 

func set_admin_pin(pin):
	_settings["hidden"]["admin_pin"] = pin

func get_admin_pin():
	return _settings["hidden"]["admin_pin"]
	
func get_date_format():
	return _settings["date"]["format"]
	
func set_date_format(value):
	_settings["date"]["format"] = value
	
func get_save_location():
	return _settings["files"]["save_location"]
	
func set_save_location(path):
	_settings["files"]["save_location"] = path

func get_db_location():
	return _settings["files"]["database_location"]


func set_db_location(path):
	_settings["files"]["database_location"] = path


func get_first_run():
	return _settings["hidden"]["first_run"]


func set_first_run(value : bool):
	if value == null: return
	_settings["hidden"]["first_run"] = value


func set_employee_color(eid, color):
	_settings["color"][str(eid)] = color
	save_settings()	


func get_employee_color(eid):
	if str(eid) in _settings["color"].keys():
		return _settings["color"][str(eid)]
	
	return DEF_COLOR


func save_settings():
	for section in _settings.keys():
		for key in _settings[section]:
			_config_file.set_value(section, key, _settings[section][key])
			
	_config_file.save(SAVE_PATH)	


func load_settings(main_window = null):
	var error = _config_file.load(SAVE_PATH)
	
	if error != OK:
		print("FAILED TO LOAD SETTINS: ERROR CODE %s" % error)
		
		return error
	
	for section in _settings.keys():
		for key in _settings[section]:
			_settings[section][key] = _config_file.get_value(section, key)
			
	for section in _config_file.get_sections():
		if not (section in _settings.keys()):
			_settings[section] = Dictionary()
			print("Adding Section: %s" % section)
			
		for key in _config_file.get_section_keys(section):
			_settings[section][key] = _config_file.get_value(section, key)
	
	if main_window != null and get_admin_pin() == "0000":
		var adminPinScene = load("res://Scenes/Admin_creator/AdminPin.tscn")
		var create_pin = adminPinScene.instance()
		main_window.add_child(create_pin)
		create_pin.show_win()


func get_hr_mm():
	return _settings["date"]["hr_mm_format"]


func set_hr_mm_format(value : bool):
	if value == null:
		return 
		
	_settings["date"]["hr_mm_format"] = value
	save_settings()


func delete_files():
	var del_dir = Directory.new()
	
	del_dir.remove(SAVE_PATH)
	dbManager.closeDB()
	del_dir.remove(get_db_location())
	get_tree().quit()