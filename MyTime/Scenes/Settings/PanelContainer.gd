extends PanelContainer

enum d {NONE, LEFT, RIGHT, UP, DOWN}

export var max_x : int
export var max_y : int
export var transition_time : float

export(d) var init_grow : int
export(d) var sec_grow : int

var first_grow_finished = true
var second_grow_finished = true

var button_active = false

var grow_up= false
var grow_down= false
var grow_left= false
var grow_right= false

var final_position = Vector2()
var init_position = Vector2()


func _ready():
	#grow = true	
	#print(get_size())
	init_position = get_position()
	final_position = get_position()
	
	
	match init_grow:
		d.UP:
			final_position.y -= max_y
			final_position.y +=  get_size().y
		d.DOWN:
			pass
		d.LEFT:
			final_position.x -= max_x
		d.RIGHT:
			final_position.x += max_x
			
	match sec_grow:
		d.UP:
			final_position.y -= max_y
			final_position.y +=  get_size().y
		d.DOWN:
			pass
		d.LEFT:
			final_position.x -= max_x
		d.RIGHT:
			final_position.x += max_x
		
	print(init_position)
	print(final_position)
	pass


func _process(delta):
	var size = get_size()
	var pos = get_position()
	var y_offset = (max_y * delta/transition_time)
	
	if grow_up:
		if size.y < max_y and (init_grow == d.UP or (first_grow_finished and sec_grow == d.UP)):
			change_up(y_offset)
		else:
			size.y = max_y
			set_size(size)
			set_position(final_position)
			grow_up = false
			
			if first_grow_finished:
				second_grow_finished = true
			else:
				first_grow_finished = true
	if grow_down:
		if size.y < max_y and (init_grow == d.DOWN or (first_grow_finished and sec_grow == d.DOWN)):
			change_down(y_offset)
		else:
			size.y = max_y
			set_size(size)
			set_position(final_position)
			grow_down = false
			
			if first_grow_finished:
				second_grow_finished = true
			else:
				first_grow_finished = true


func change_up(dist):
	var size = get_size()
	var pos = get_position()
	size.y += dist
	set_size(size)
	pos.y -= dist
	set_position(pos)

func change_down(dist):
	var size = get_size()
	var pos = get_position()
	size.y += dist
	set_size(size)

func selector():
	button_active = not button_active
	
	first_grow_finished = false
	second_grow_finished = false
	
	if button_active:
		if init_grow == d.UP or sec_grow == d.UP:
			grow_up = true
			grow_down = false
		elif init_grow == d.DOWN or sec_grow == d.DOWN:
			grow_down = true
			grow_up = false
			
	else:
		if init_grow == d.UP or sec_grow == d.UP:
			grow_up = false
			grow_down = not grow_up
		elif init_grow == d.DOWN or sec_grow == d.DOWN:
			grow_down = false
			grow_up = not grow_down
	pass
	
	
	
func _on_Button_pressed():
	selector()
	
	#self.visible = button_active
	pass # Replace with function body.
