extends Node2D

var previousMonsterPowerRelease = preload("res://scenes/monsterPower.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func power_release():
	var numMonsters = get_node("monsters").get_child_count()
	var monster = get_node("monsters").get_child(randi() % numMonsters)
	var monsterPowerRelease = previousMonsterPowerRelease.instance()
	get_parent().add_child(monsterPowerRelease)
	monsterPowerRelease.set_global_position(monster.get_global_position())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_timerPowerRelease_timeout():
	power_release()
