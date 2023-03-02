extends VBoxContainer


const previousItem = preload("res://scenes/scoreItemBoxContainer.tscn")
const playersRank = ["1ST", "2ND", "3RD", "4TH", "5TH", "6TH", "7TH", "8TH", "9TH", "10TH"]
const colorList = ["ff0200", "e87200", "ffe400", "00ac00", "0c00ff", "4b0082", "ee82ee", "ee82ff", "e5abf3", "ffffff"]

# Called when the node enters the scene tree for the first time.
func _ready():
	#test()
	pass


func test():
	for anything in range(10):
		var item = previousItem.instance()
		item.playerRank = playersRank[anything]
		item.playerName = str(anything) + "AA"
		add_child(item)
		get_node("highScoreTimer").start()
		yield(get_node("highScoreTimer"), "timeout")

func show_highScores(highScore):
	#class_name = HBoxContainer
	for hsItem in get_children():
		if hsItem is HBoxContainer:
			hsItem.queue_free()
	
	#Header for the high score
	var item = previousItem.instance()
	item.playerRank = "RANK"
	item.playerName = "NAME"
	item.playerScore = "SCORE"
	add_child(item)
	
	var nextRank = 0
	for hs in highScore:
		item = previousItem.instance()
		item.playerRank = playersRank[nextRank]
		item.playerName = hs.name
		item.playerScore = hs.score
		item.scoreColor = Color(colorList[nextRank])
		add_child(item)
		get_node("highScoreTimer").start()
		yield(get_node("highScoreTimer"), "timeout")
		nextRank += 1
