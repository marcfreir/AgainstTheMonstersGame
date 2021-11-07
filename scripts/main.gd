extends Node

var previousGame = preload("res://scenes/game.tscn")
var game

var extraLifeIndex = 0
var score = 0
var playerLives = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func new_game():
	if game != null:
		game.queue_free()
	game = previousGame.instance()
	add_child(game)
	game.connect("game_over", self, "on_game_over")
	game.connect("victory", self, "on_victory")


func _on_Button_pressed():
	get_node("btnNewGame").hide()
	new_game()
	
func on_game_over():
	get_node("btnNewGame").show()

func on_victory():
	extraLifeIndex = game.extraLifeIndex
	score = game.score
	playerLives = game.playerLives
	new_game()
	game.extraLifeIndex = extraLifeIndex
	game.score = score
	game.playerLives = playerLives
	game.update_HUD()
