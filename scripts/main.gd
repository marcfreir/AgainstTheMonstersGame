extends Node

var previousNameSelector = preload("res://scenes/nameSelector.tscn")
var previousGame = preload("res://scenes/game.tscn")
var game

var highScores = [
	{name = "AAA", score = 1000},
	{name = "BBB", score = 900},
	{name = "CCC", score = 800},
	{name = "DDD", score = 700},
	{name = "EEE", score = 600},
	{name = "FFF", score = 500},
	{name = "GGG", score = 400},
	{name = "HHH", score = 300},
	{name = "III", score = 200},
	{name = "JJJ", score = 100}
]

var high_score

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("highScore").show_highScores(highScores)
	pass


func new_game():
	if game != null:
		game.queue_free()
	game = previousGame.instance()
	
	get_node("gameNode").add_child(game)
	# Give me an error
	#add_child(game)
	
	# Replacement/Update
	call_deferred("add_child", game)
	
	game.connect("game_over", self, "on_game_over")
	game.connect("victory", self, "on_victory")


func _on_Button_pressed():
	get_node("btnNewGame").hide()
	get_node("highScore").hide()
	new_game()
	
func on_game_over():
	high_score = null
	for hs in highScores:
		if game.gameData.score > hs.score:
			high_score = hs
			break
			
	if high_score != null:
		var nameSelector = previousNameSelector.instance()
		add_child(nameSelector)
		nameSelector.connect("finished", self, "on_nameSelector_finished")
		yield(nameSelector, "finished")
		print("finished")
		nameSelector.queue_free()
		
	get_node("btnNewGame").show()
	get_node("highScore").show()
	get_node("highScore").show_highScores(highScores)

func on_victory():
	var gameData = game.gameData
	new_game()
	game.gameData = gameData

func on_nameSelector_finished(playerNameValue):
	#print(highScores)
	var highScoresIndex = highScores.find(high_score)
	highScores.insert(highScoresIndex, {name = playerNameValue, score = game.gameData.score})
	highScores.resize(10)
	#print(highScores)
