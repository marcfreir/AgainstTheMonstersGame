extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("animationExplosion").play("explosion")
	yield(get_node("animationExplosion"), "animation_finished")
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
