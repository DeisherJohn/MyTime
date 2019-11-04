extends Node

const SAVE_PATH = "res://config.cfg"

enum DATE_FORMAT {MMDDYYYY = 0, DDMMYYYY = 1}

var _config_file = ConfigFile.new()

var _settings = {
	"admin":{
		"pin":null
	},
	"date":{
		"format":DATE_FORMAT.MMDDYYYY
	}
	
}




func load_settings():
	
	pass