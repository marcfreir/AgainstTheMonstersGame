tool
extends Node2D

export(Texture) var lifeTexture

export var playerLives = 3 setget set_playerLives



func _draw():
	for life in range(playerLives):
		draw_texture_rect_region(lifeTexture, Rect2(life * (11 + 1),0,11,10), Rect2(0,0,11,10), Color(1,1,1,1), false)
		pass

func set_playerLives(value):
	playerLives = value
	update()
