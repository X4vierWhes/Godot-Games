extends Node
class_name inputComponent

signal inputDetection(direction: Vector2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
		var direction: Vector2 = Vector2(0, -1)
		emit_signal("inputDetection",direction)
	elif event.is_action_pressed("move_right"):
		var direction: Vector2 = Vector2(1, 0)
		emit_signal("inputDetection",direction)
	elif event.is_action_pressed("move_down"):
		var direction: Vector2 = Vector2(0, 1)
		emit_signal("inputDetection",direction)
	elif event.is_action_pressed("move_left"):
		var direction: Vector2 = Vector2(-1, 0)
		emit_signal("inputDetection",direction)
