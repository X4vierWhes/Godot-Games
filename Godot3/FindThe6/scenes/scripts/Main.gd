extends Node2D

var novabomba = preload("res://scenes/Bomba.tscn")
var enemy = preload("res://scenes/Enemy.tscn")
var totalinimigos = 0
var teasures = preload("res://scenes/tesouro.tscn")
var totalteasues = 0

func _ready():
	#$theme.play()
	randomize()
	set_cam_limit()

func _on_Player_criabomba():
	var bomba = novabomba.instance()
	add_child(bomba)
	bomba.position.x = $Player.retX()
	bomba.position.y = $Player.retY()

func set_cam_limit():
	var map_size = $solo.get_used_rect()
	var cell_size = $solo.cell_size
	$Camera2D.limit_left = map_size.position.x * cell_size.x
	$Camera2D.limit_top = map_size.position.y * cell_size.y
	$Camera2D.limit_right = map_size.end.x * cell_size.x
	$Camera2D.limit_bottom = map_size.end.y * cell_size.y


func _on_spawnEnemy_timeout():
	if totalinimigos < 20:
		var spawn = enemy.instance()
		add_child(spawn)
		spawn.position.x = rand_range(-1600, 2600)
		spawn.position.y = rand_range(1800, -1800)
		totalinimigos+=1
		


func _on_teasures_timeout():
	if totalteasues < 8:
		var spawn2 = teasures.instance()
		add_child(spawn2)
		spawn2.position.x = rand_range(-1600, 2600)
		spawn2.position.y = rand_range(1800, -1800)
		totalteasues+=1


func _on_Player_win():
	$HUD/Label.text = "GANHOUU!!!"
	$repeat.start()


func _on_repeat_timeout():
	get_tree().reload_current_scene()
