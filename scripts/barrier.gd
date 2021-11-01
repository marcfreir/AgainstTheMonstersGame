extends Area2D

var barrierHit = 0

func destroy(object):
	barrierHit += 1
	if barrierHit > 5:
		queue_free()
	get_node("barrierSprite").set_frame(barrierHit)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
