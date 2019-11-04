extends HBoxContainer

var pin1 = null
var pin2 = null

signal pin_status(value)


func _ready():
	pass

func get_data():
	var dict = Dictionary()
	
	var temp = $DataLine.get_data()
	for key in temp.keys():
		dict[key] = temp[key]
		
	return dict
	

func pins_match():
	if pin1 == pin2 and len(pin1) == 4 and pin1.is_valid_integer():
		$Label.set_text("Match")
		emit_signal("pin_status", true)
	else:
		$Label.set_text("Mis-Match")
		emit_signal("pin_status", false)

func _on_DataLine_pin_changed(new_text):
	pin1 = new_text
	pins_match()


func _on_DataLine2_pin_changed(new_text):
	pin2 = new_text
	pins_match()
