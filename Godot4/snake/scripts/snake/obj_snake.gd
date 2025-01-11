extends Node2D
class_name Snake

@onready var direction: Vector2 = Vector2.ZERO
@onready var canMove: bool = false
@onready var body: Array = [self]

const scene_tail = preload("res://scenes/snake/obj_tail.tscn")

signal move_input_detected(entity: Node2D, direction: Vector2)
signal generate_tail_segment(segment: Node2D, segment_position: Vector2)
signal body_segment_move_detected(segment: Node2D, segment_position: Vector2)

func _ready() -> void:
	$inputComponent.connect("inputDetection", playerInputDetection)
	

func _process(delta: float) -> void:
	if direction != Vector2.ZERO && canMove:
		var old_pos: Vector2 = self.position
		emit_signal("move_input_detected", self, direction)
		if body.size() > 1:
			for i in range(1, body.size()):
				var temp_pos: Vector2 = body[i].position
				emit_signal("body_segment_move_detected", body[i], old_pos)
				old_pos = temp_pos
				
		canMove = false
		$MoveDelay.start()

func playerInputDetection(newDirection: Vector2) -> void:
	if newDirection != direction * (-1):
		direction = newDirection
		print(direction)

func eat_food() -> void:
	var tail: Node2D = scene_tail.instantiate() as Node2D
	body.append(tail)
	emit_signal("generate_tail_segment", tail, body[-2].position)

func _on_move_delay_timeout() -> void:
	canMove = true 
