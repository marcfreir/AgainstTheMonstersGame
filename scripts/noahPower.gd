extends Area2D


var powerSpeed = 180
var powerDirection = Vector2(0,-1)


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("noahPower")
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(powerDirection * powerSpeed * delta)
	
	if get_global_position().y < 0:
		queue_free()


func _on_noahPower_area_entered(area):
	if area.has_method("destroy"):
		area.destroy(self)
		destroy(self)
		
func destroy(object):
	queue_free()
