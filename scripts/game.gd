extends Node

const extraLifePoints = [1000, 5000, 10000]

var gameData = {
	extraLifeIndex = 0,
	score = 0,
	playerLives = 3
} setget set_gameData


signal game_over
signal victory

# Called when the node enters the scene tree for the first time.
func _ready():
	$backgroundMusicAudioStreamPlayer.play()
	randomize()
	update_score()
	get_node("monsterGroup").connect("enemy_down", self, "on_monsterGroup_enemy_down")
	get_node("monsterGroup").connect("enemy_ready", self, "on_monsterGroup_enemy_ready")
	get_node("monsterGroup").connect("area_conquered", self, "on_monsterGroup_area_conquered")
	get_node("monsterGroup").connect("victory", self, "on_monsterGroup_victory")
	get_node("player").connect("dead", self, "on_player_dead")
	get_node("player").connect("respawn", self, "on_player_respawn")


func on_monsterGroup_enemy_down(monster):
	gameData.score += monster.score
	if gameData.extraLifeIndex < extraLifePoints.size() and gameData.score >= extraLifePoints[gameData.extraLifeIndex]:
		gameData.playerLives += 1
		update_playerLives()
		gameData.extraLifeIndex += 1
	update_score()

func on_monsterGroup_enemy_ready():
	get_node("player").start()

func on_monsterGroup_area_conquered():
	game_over()

func on_monsterGroup_victory():
	get_node("monsterGroup").stop_all()
	get_node("player").disable()
	emit_signal("victory")

func update_score():
	get_node("HUD/scoreLabel").set_text(str(gameData.score))

func update_playerLives():
	get_node("HUD/showLife").playerLives = gameData.playerLives

func update_HUD():
	update_score()
	update_playerLives()

func on_player_dead():
	get_node("monsterGroup").stop_all()
	gameData.playerLives -= 1
	update_playerLives()
	get_tree().call_group("MONSTER_POWER", "destroy", self)
	

func on_player_respawn():
	if gameData.playerLives <= 0:
		game_over()
	else:
		get_node("monsterGroup").start_all()


func game_over():
	$backgroundMusicAudioStreamPlayer.stop()
	get_node("monsterGroup").stop_all()
	get_node("player").disable()
	get_node("player").queue_free()
	emit_signal("game_over")

func set_gameData(value):
	gameData = value
	update_HUD()
