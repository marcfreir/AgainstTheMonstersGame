extends Node

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	update_score()
	get_node("monsterGroup").connect("enemy_down", self, "on_monsterGroup_enemy_down")


func on_monsterGroup_enemy_down(monster):
	score += monster.score
	update_score()

func update_score():
	get_node("HUD/scoreLabel").set_text(str(score))
