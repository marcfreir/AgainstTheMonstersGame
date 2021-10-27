extends Area2D

var right
var left

var direction

const SPEED = 80

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	direction = 0
	right = Input.is_action_pressed("ui_right")
	left = Input.is_action_pressed("ui_left")
	
	if right:
		direction += 1
	
	if left:
		direction -= 1
		
	translate(Vector2(1,0) * SPEED * direction * delta)
	
	# Set limit to the x axis
	if get_global_position().x < 8:
		set_global_position(Vector2(8, get_global_position().y))
	if get_global_position().x > 172:
		set_global_position(Vector2(172, get_global_position().y))
	
	
