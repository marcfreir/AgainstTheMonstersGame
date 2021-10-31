tool

extends Area2D

export(int, "A", "B", "C") var type = 0 setget set_type

var score = 0
var monsterSprite

var attributes = [
	{
		monsterSprite = preload("res://sprites/monsterA_sheet.png"),
		score = 10
	},
	{
		monsterSprite = preload("res://sprites/monsterB_sheet.png"),
		score = 20
	},
	{
		monsterSprite = preload("res://sprites/monsterC_sheet.png"),
		score = 30
	}
		
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _draw():
	var attribute = attributes[type]
	get_node("monsterBSprite").set_texture(attribute.monsterSprite)
	score = attribute.score

func set_type(value):
	type = value
	if is_inside_tree() and Engine.editor_hint:
		update()
