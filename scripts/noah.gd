extends Area2D

var right
var left

var direction

var previousRelease = preload("res://scenes/noahPower.tscn")
var previousPower = false
var power

const SPEED = 80

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	direction = 0
	right = Input.is_action_pressed("ui_right")
	left = Input.is_action_pressed("ui_left")
	power = Input.is_action_pressed("throw")
	
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
		
	if power and not previousPower and get_tree().get_nodes_in_group("noahPower").size() == 0:
		var release = previousRelease.instance()
		get_parent().add_child(release)
		release.set_global_position(get_global_position())
		
	previousPower = power
	
