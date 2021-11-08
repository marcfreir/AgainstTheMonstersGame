extends Node

const characterList = "ABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789 *#"

var index = 0
var character = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)


func _input(event):
	var indexChanged = false
	if event.is_action_pressed("ui_right") and not event.is_echo():
		index += 1
		indexChanged = true
	
	if event.is_action_pressed("ui_left") and not event.is_echo():
		index -= 1
		indexChanged = true
	
	if indexChanged:
		if index < 0:
			index = characterList.length() - 1
		elif index >= characterList.length():
			index = 0
		get_node("boxContainer").get_child(character).set_text(characterList[index])


func _on_nameTimer_timeout():
	if get_node("boxContainer").get_child(character).get_visible_characters() > 0:
		get_node("boxContainer").get_child(character).set_visible_characters(0)
	else:
		get_node("boxContainer").get_child(character).set_visible_characters(1)
