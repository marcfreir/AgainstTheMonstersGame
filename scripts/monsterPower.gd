extends Area2D

const speed = 120
const direction = Vector2(0,1)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(direction * speed * delta)
	if get_global_position().y > 265:
		destroy(self)
	
func destroy(object):
	queue_free()


func _on_monsterPower_area_entered(area):
	print(area)
