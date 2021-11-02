extends Node

const extraLifePoints = [1000, 5000, 10000]

var extraLifeIndex = 0

var score = 0

var playerLives = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	update_score()
	get_node("monsterGroup").connect("enemy_down", self, "on_monsterGroup_enemy_down")
	get_node("monsterGroup").connect("enemy_ready", self, "on_monsterGroup_enemy_ready")
	get_node("monsterGroup").connect("area_conquered", self, "on_monsterGroup_area_conquered")
	get_node("monsterGroup").connect("victory", self, "on_monsterGroup_victory")
	get_node("player").connect("dead", self, "on_player_dead")
	get_node("player").connect("respawn", self, "on_player_respawn")


func on_monsterGroup_enemy_down(monster):
	score += monster.score
	if extraLifeIndex < extraLifePoints.size() and score >= extraLifePoints[extraLifeIndex]:
		playerLives += 1
		get_node("HUD/showLife").playerLives = playerLives
		extraLifeIndex += 1
	update_score()

func on_monsterGroup_enemy_ready():
	get_node("player").start()

func on_monsterGroup_area_conquered():
	game_over()

func on_monsterGroup_victory():
	print("on_monsterGroup_victory")

func update_score():
	get_node("HUD/scoreLabel").set_text(str(score))

func on_player_dead():
	get_node("monsterGroup").stop_all()
	playerLives -= 1
	get_node("HUD/showLife").playerLives = playerLives
	get_tree().call_group("MONSTER_POWER", "destroy", self)
	

func on_player_respawn():
	if playerLives <= 0:
		game_over()
	else:
		get_node("monsterGroup").start_all()


func game_over():
	get_node("monsterGroup").stop_all()
	get_node("player").disable()
