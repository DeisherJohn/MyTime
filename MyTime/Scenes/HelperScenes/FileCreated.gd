extends AcceptDialog

func _ready():
	self.popup_centered()

func set_text(cond = false):
	if cond == true:
		$MarginContainer/Label.set_text("File Creation: Success")
	else:
		$MarginContainer/Label.set_text("File Creation: Failed")

func _on_Control_popup_hide():
	queue_free()
	pass # Replace with function body.
