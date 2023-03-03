extends Node

const HIGHSCORE_FILE = "user://highscore_file.mkf"

var previousNameSelector = preload("res://scenes/nameSelector.tscn")
var previousGame = preload("res://scenes/game.tscn")
var game
var password = [52, 67, 78, 49, 42, 102, 95, 83, 73, 119, 123, 38]
#var passList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

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

func randomNumbers(passworList):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	#Range of characters in the ASCII table
	#print(rng.randi_range(33, 126))
	#var randomNUmber = rng.randi_range(33, 126)
	#print(randomNUmber)
	
	#passworList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
	
	var newPassList = []
	
	for element in passworList:
		var randomNumber = rng.randi_range(33, 126)
		#print(randomNumber)
		newPassList.append(randomNumber)
	
	print(newPassList)
	#print(passworList)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	#var pl = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
	#randomNumbers(pl)
	
	#print(PoolByteArray(password).get_string_from_utf8())
	load_highScore()
	get_node("highScore").show_highScores(highScores)


func new_game():
	if game != null:
		game.queue_free()
	game = previousGame.instance()
	
	get_node("gameNode").add_child(game)
	# Give me an error
	#add_child(game)
	
	# Replacement/Update
	#call_deferred("add_child", game)
	
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
		
		save_highScore()
		
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

func save_highScore():
	var hsFile = File.new()
	#var result = hsFile.open(HIGHSCORE_FILE, hsFile.WRITE)
	
	#var result = hsFile.open_encrypted_with_pass(HIGHSCORE_FILE, hsFile.WRITE, PoolByteArray(password).get_string_from_utf8())
	var result = hsFile.open_encrypted_with_pass(HIGHSCORE_FILE, hsFile.WRITE, PoolByteArray(password).get_string_from_utf8())
	print(result)
	
	if result == OK:
		var storeHighScore = {
			highScoreList = highScores
		}
		#hsFile.store_string(to_json(storeHighScore))
		hsFile.store_string(JSON.print(storeHighScore))
		hsFile.close()



func load_highScore():
	var hsFile = File.new()
	#var result = hsFile.open(HIGHSCORE_FILE, hsFile.READ)
	var result = hsFile.open_encrypted_with_pass(HIGHSCORE_FILE, hsFile.READ, PoolByteArray(password).get_string_from_utf8())
	
	if result == OK:
		var textHighScore = hsFile.get_as_text()
		var storeHighScore = parse_json(textHighScore)
		#print(storeHighScore)
		highScores = storeHighScore.highScoreList
		hsFile.close()

