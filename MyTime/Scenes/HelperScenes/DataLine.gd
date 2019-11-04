extends HBoxContainer

export var line_string : String = "Line Name"
export var key : String = "first_name"
export var for_pin : bool

signal pin_changed(new_text)

func _ready():
	$Label.set_text(line_string)
	
	if for_pin:
		$LineEdit.set_max_length(4)
		$LineEdit.secret = true


func set_data(data):
	$LineEdit.set_text(data[key])
	
func get_data():
	var dict = Dictionary()
	dict[key] = $LineEdit.get_text()
	
	if dict[key] == "": return null
	
	return dict
	

func _on_LineEdit_text_changed(new_text):
	
	if for_pin:
		emit_signal("pin_changed", new_text)
	pass # Replace with function body.
