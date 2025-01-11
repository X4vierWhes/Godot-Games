extends Node2D
class_name Snake

@onready var direction: Vector2 = Vector2.ZERO
@onready var canMove: bool = false

signal move_input_detected(entity: Node2D, direction: Vector2)

func _ready() -> void:
	$inputComponent.connect("inputDetection", playerInputDetection)
	

func _process(delta: float) -> void:
	if direction != Vector2.ZERO && canMove:
		emit_signal("move_input_detected", self, direction)
		canMove = false
		$MoveDelay.start()

func playerInputDetection(newDirection: Vector2) -> void:
	if newDirection != direction * (-1):
		direction = newDirection
		print(direction)


func _on_move_delay_timeout() -> void:
	canMove = true 
