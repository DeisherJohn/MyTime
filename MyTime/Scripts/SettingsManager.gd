extends Node

const SAVE_PATH = "res://config.cfg"

enum DATE_FORMAT {MMDDYYYY = 0, DDMMYYYY = 1}

var _config_file = ConfigFile.new()

var _settings = {
	"hidden":{
		"admin_pin":"0000"
	},
	"date":{
		"format":DATE_FORMAT.MMDDYYYY
	},
	"files":{
		"save_location":"C:/Users/John Deisher/Documents/GitHub/MyTime/Reports/"
	}
}

func _ready():
	load_settings()
	print(_settings["files"]["save_location"])
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
	var path = _settings["files"]["save_location"]
	return path
	
func set_save_location(path):
	_settings["files"]["save_location"] = path

func save_settings():
	for section in _settings.keys():
		for key in _settings[section]:
			_config_file.set_value(section, key, _settings[section][key])
			
	_config_file.save(SAVE_PATH)	

func load_settings(main_window = null):
	var error = _config_file.load(SAVE_PATH)
	
	if error != OK:
		print("FAILED TO LOAD SETTINS: ERROR CODE %s" % error)
		return null
	
	for section in _settings.keys():
		for key in _settings[section]:
			_settings[section][key] = _config_file.get_value(section, key)
	
	
	if main_window != null and get_admin_pin() == "0000":
		var adminPinScene = load("res://Scenes/Admin_creator/AdminPin.tscn")
		var create_pin = adminPinScene.instance()
		main_window.add_child(create_pin)
		create_pin.show_win()
