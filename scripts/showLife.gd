extends Node2D

export(Texture) var lifeTexture

var playerLives = 3



func _draw():
	for life in range(playerLives):
		draw_texture_rect_region(lifeTexture, Rect2(life * 11,0,11,10), Rect2(0,0,11,10), Color(1,1,1,1), false)
		pass
