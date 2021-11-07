extends Area2D

var score = 200

signal animation_destroyed(object)

# Called when the node enters the scene tree for the first time.
func _ready():
	$audioMotherShip.play()
	get_node("animationMSRun").play("runMotherShip")
	yield(get_node("animationMSRun"), "animation_finished")
	queue_free()


func destroy(object):
	emit_signal("animation_destroyed", self)
	queue_free()
