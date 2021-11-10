extends VBoxContainer


const previousItem = preload("res://scenes/scoreItemBoxContainer.tscn")
const playersRank = ["1ST", "2ND", "3RD", "4TH", "5TH", "6TH", "7TH", "8TH", "9TH", "10TH"]

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
	var nextRank = 0
	for hs in highScore:
		var item = previousItem.instance()
		item.playerRank = playersRank[nextRank]
		item.playerName = hs.name
		item.playerScore = hs.score
		add_child(item)
		get_node("highScoreTimer").start()
		yield(get_node("highScoreTimer"), "timeout")
		nextRank += 1
