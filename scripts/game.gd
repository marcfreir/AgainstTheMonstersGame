extends Node

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	update_score()
	get_node("monsterGroup").connect("enemy_down", self, "on_monsterGroup_enemy_down")
	get_node("player").connect("dead", self, "on_player_dead")
	get_node("player").connect("respawn", self, "on_player_respawn")


func on_monsterGroup_enemy_down(monster):
	score += monster.score
	update_score()

func update_score():
	get_node("HUD/scoreLabel").set_text(str(score))

func on_player_dead():
	get_node("monsterGroup").stop_all()

func on_player_respawn():
	get_node("monsterGroup").start_all()
