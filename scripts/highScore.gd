extends VBoxContainer


const previousItem = preload("res://scenes/scoreItemBoxContainer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for anything in range(10):
		var item = previousItem.instance()
		item.playerName = str(anything) + "AA"
		add_child(item)

	pass
