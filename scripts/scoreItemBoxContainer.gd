extends HBoxContainer


var playerRank = "1ST" setget set_playerRank
var playerName = "AAA" setget set_playerName
var playerScore = "999999" setget set_playerScore


func set_playerRank(value):
	playerRank = value
	get_node("rank").set_text(str(value))
	
func set_playerName(value):
	playerName = value
	get_node("name").set_text(str(value))

func set_playerScore(value):
	playerScore = value
	get_node("score").set_text(str(value))
