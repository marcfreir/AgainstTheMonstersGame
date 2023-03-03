extends Area2D

const SPEED = 80

var right
var left

var direction
var previousRelease = preload("res://scenes/noahPower.tscn")
var previousPower = false
var power

var isAlive = true

signal dead
signal respawn

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	#set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	direction = 0
	right = Input.is_action_pressed("ui_right")
	left = Input.is_action_pressed("ui_left")
	power = Input.is_action_pressed("release")
	
	if right:
		direction += 1
	
	if left:
		direction -= 1
		
	translate(Vector2(1,0) * SPEED * direction * delta)
	
#	# Set limit to the x axis ("if" version)
#	if get_global_position().x < 8:
#		set_global_position(Vector2(8, get_global_position().y))
#	if get_global_position().x > 172:
#		set_global_position(Vector2(172, get_global_position().y))

	# Set limit to the x axis ("clamp" version)
	set_global_position(Vector2(clamp(get_global_position().x, 8, ProjectSettings.get("display/window/size/width") - 7), get_global_position().y))
	
		
	if power and not previousPower and get_tree().get_nodes_in_group("noahPower").size() < 100:
		$audioPlayerPowerRelease.play()
		var release = previousRelease.instance()
		get_parent().add_child(release)
		release.set_global_position(get_global_position())
		
	previousPower = power
	
func start():
	show()
	set_process(true)

func disable():
	hide()
	set_process(false)
	isAlive = false

# Destroy the mains character
func destroy(object):
	if isAlive:
		$audioPlayerExplosion.play()
		isAlive = false
		set_process(false)
		emit_signal("dead")
		get_node("animationPlayer").play("transformation")
		yield(get_node("animationPlayer"), "animation_finished")
		emit_signal("respawn")
		set_process(true)
		isAlive = true
		get_node("mainSprite").set_frame(0)
