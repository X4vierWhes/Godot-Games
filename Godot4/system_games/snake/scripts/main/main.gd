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
	setup_snake_entity()
	setup_food_entity()

func setup_snake_entity() -> void:
	player = scene_snake.instantiate() as Node2D
	player.connect("move_input_detected", move_snake)
	player.connect("generate_tail_segment", generate_tail)
	player.connect("body_segment_move_detected", body_move)
	add_child(player)
	grid.place_entity_at_random_pos(player)

func setup_food_entity() -> void:
	var food = scene_food.instantiate() as Node2D
	add_child(food)
	grid.place_entity_at_random_pos(food)

func move_snake(entity: Node2D, direction: Vector2) -> void:
	grid.move_entity_in_direction(entity, direction)

func body_move(segment: Node2D, position: Vector2) -> void:
	grid.move_entity_to_position(segment, position)

func generate_tail(segment: Node2D, position: Vector2) -> void:
	add_child(segment)
	grid.place_entity(segment, grid.world_to_map(position))

func _on_grid_moved_into_death() -> void:
	delete_entities_of_group("Food")
	delete_entities_of_group("Player")
	
	setup_entities()

func delete_entities_of_group(name: String) -> void:
	var entities: Array = get_tree().get_nodes_in_group(name) as Array
	
	for entity in entities:
		entity.queue_free()


func _on_grid_moved_into_food(food_entity: Node2D, entity: Node2D) -> void:
	if entity.has_method("eat_food"):
		entity.eat_food()
		food_entity.queue_free()
		setup_food_entity()
