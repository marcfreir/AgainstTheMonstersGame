extends HBoxContainer


var playerRank = "1ST" setget set_playerRank
var playerName = "AAA" setget set_playerName
var playerScore = "999999" setget set_playerScore
var scoreColor = Color(1,1,1,1) setget set_scoreColor


func set_playerRank(value):
	playerRank = value
	get_node("rank").set_text(str(value))
	
func set_playerName(value):
	playerName = value
	get_node("name").set_text(str(value))

func set_playerScore(value):
	playerScore = value
	get_node("score").set_text(str(value))

func set_scoreColor(value):
	scoreColor = value
	get_node("rank").set("custom_colors/font_color", scoreColor)
	get_node("name").set("custom_colors/font_color", scoreColor)
	get_node("score").set("custom_colors/font_color", scoreColor)
	
