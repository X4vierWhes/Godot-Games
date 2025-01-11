extends Node

const scene_food = preload("res://scenes/food/obj_food.tscn")
const scene_snake = preload("res://scenes/snake/obj_snake.tscn")

@onready var grid: Grid = get_node("Grid") as Grid

var player:Node2D
var food: Node2D

func _ready() -> void:
	
	setup_entities()

func setup_entities() -> void:
	randomize()
	player = scene_snake.instantiate() as Node2D
	player.connect("move_input_detected", move_snake)
	add_child(player)
	grid.place_entity_at_random_pos(player)
	
	food = scene_food.instantiate() as Node2D
	add_child(food)
	grid.place_entity_at_random_pos(food)

func move_snake(entity: Node2D, direction: Vector2) -> void:
	grid.move_entity_in_direction(entity, direction)
