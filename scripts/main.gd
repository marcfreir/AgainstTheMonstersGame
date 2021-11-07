extends Node

var previousGame = preload("res://scenes/game.tscn")
var game


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func new_game():
	if game != null:
		remove_child(game)
	game = previousGame.instance()
	add_child(game)
	game.connect("game_over", self, "on_game_over")


func _on_Button_pressed():
	get_node("btnNewGame").hide()
	new_game()
	
func on_game_over():
	get_node("btnNewGame").show()
