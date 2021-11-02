extends Node2D

const speed = Vector2(6, 0)

var previousMonsterPowerRelease = preload("res://scenes/monsterPower.tscn")
var previousMonsterExplosion = preload("res://scenes/monsterExplosion.tscn")
var previousMotherShip = preload("res://scenes/motherShip.tscn")

var direction = 1

signal enemy_down(object)
signal enemy_ready
signal area_conquered

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("timerPowerRelease").start()
	restart_timer_motherShip()
	for monster in get_node("monsters").get_children():
		monster.hide()
		monster.connect("animation_destroyed", self, "on_monster_destroyed")
		
	for monster in get_node("monsters").get_children():
		get_node("timerMonstersPause").start()
		yield(get_node("timerMonstersPause"), "timeout")
		monster.show()
	
	emit_signal("enemy_ready")
	start_all()


func power_release():
	var numMonsters = get_node("monsters").get_child_count()
	var monster = get_node("monsters").get_child(randi() % numMonsters)
	var monsterPowerRelease = previousMonsterPowerRelease.instance()
	get_parent().add_child(monsterPowerRelease)
	monsterPowerRelease.set_global_position(monster.get_global_position())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_timerPowerRelease_timeout():
	get_node("timerPowerRelease").set_wait_time(rand_range(.5, 3))
	power_release()


func _on_timerMonstersMove_timeout():
	
	var border = false
	
	for monster in get_node("monsters").get_children():
		monster.next_frame()
		if monster.get_global_position().x > 170 and direction > 0:
			direction = -1
			border = true
		if monster.get_global_position().x < 10 and direction < 0:
			direction = 1
			border = true
		
		if monster.get_global_position().y > 260:
			emit_signal("area_conquered")
	
	if border:
		translate(Vector2(0, 8))
		if get_node("timerMonstersMove").get_wait_time() > .3:
			get_node("timerMonstersMove").set_wait_time(get_node("timerMonstersMove").get_wait_time() - .05)
	else:
		translate(speed * direction)

func on_monster_destroyed(monster):
	emit_signal("enemy_down", monster)
	var monsterExplosion = previousMonsterExplosion.instance()
	get_parent().add_child(monsterExplosion)
	monsterExplosion.set_global_position(monster.get_global_position())


func _on_timerMotherShip_timeout():
	var motherShip = previousMotherShip.instance()
	motherShip.connect("animation_destroyed", self, "on_monster_destroyed")
	get_parent().add_child(motherShip)
	restart_timer_motherShip()

func restart_timer_motherShip():
	get_node("timerMotherShip").set_wait_time(rand_range(6, 12))
	get_node("timerMotherShip").start()

func stop_all():
	get_node("timerMotherShip").stop()
	get_node("timerPowerRelease").stop()
	get_node("timerMonstersMove").stop()

func start_all():
	get_node("timerMotherShip").start()
	get_node("timerPowerRelease").start()
	get_node("timerMonstersMove").start()
