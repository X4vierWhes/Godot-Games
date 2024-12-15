extends Node2D
class_name Snake

var direction: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	#Direção da cobra
	if Input.is_action_pressed("move_up"):
		move_Snake(Vector2(0, -1))
	elif Input.is_action_pressed("move_right"):
		move_Snake(Vector2(1, 0))
	elif Input.is_action_pressed("move_down"):
		move_Snake(Vector2(0, -1))
	elif Input.is_action_pressed("move_left"):
		move_Snake(Vector2(-1, 0))
	
	#print(direction)
	


func move_Snake(newDirection: Vector2):
	if newDirection != direction*(-1):
		direction = newDirection
