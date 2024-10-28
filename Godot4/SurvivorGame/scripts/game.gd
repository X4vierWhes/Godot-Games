extends Node2D

var enemies:int = 0
var points:int = 0
@export var ui:CanvasLayer
@export var player: CharacterBody2D


func _process(delta: float) -> void:
	if player.has_method("_getState"):
		if player._getState():
			get_tree().reload_current_scene()
		else:
			pass

func spawn():
	var mob = preload(
		"res://scenes/enemyScene/obj_pig.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	mob.global_position = %PathFollow2D.global_position
	add_child(mob)

func _decrement():
	enemies-=1
	points+=1
	ui._update_enemies_label(enemies)
	ui._upadate_points_label(points)

func _on_timer_timeout():
	if enemies < 100 :
		spawn()
		enemies += 1
		ui._update_enemies_label(enemies)
