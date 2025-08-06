extends TileMap
class_name Grid

@onready var grid_size: Vector2 = Vector2(32, 24)
@onready var cell_size: Vector2 = Vector2(32, 32)

signal moved_into_death
signal moved_into_food(food_entity: Node2D, entity: Node2D)

var grid: Array

func _ready() -> void:
	position = Vector2.ZERO
	setup_grid()

func _draw() -> void:
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			var position = Vector2(x, y) * cell_size
			var rect = Rect2(position, cell_size)
			draw_rect(rect, Color(1, 1, 1, 0.1), false)

func setup_grid() -> void:
	grid = []
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)

func get_entity_of_cell(grid_pos: Vector2) -> Node2D:
	if is_within_bounds(grid_pos):
		return grid[grid_pos.x][grid_pos.y] as Node2D
	return null

func set_entity_in_cell(entity: Node2D, grid_pos: Vector2) -> void:
	if is_within_bounds(grid_pos):
		grid[grid_pos.x][grid_pos.y] = entity

func is_within_bounds(grid_pos: Vector2) -> bool:
	return grid_pos.x >= 0 and grid_pos.x < grid_size.x and grid_pos.y >= 0 and grid_pos.y < grid_size.y

func place_entity(entity: Node2D, grid_pos: Vector2) -> void:
	if is_within_bounds(grid_pos):
		set_entity_in_cell(entity, grid_pos)
		entity.global_position = _to_global(grid_pos) + cell_size/2

func place_entity_at_random_pos(entity: Node2D) -> void:
	var has_random_pos = false
	var random_grid_pos: Vector2

	while not has_random_pos:
		var temp_pos: Vector2 = Vector2(
			randi() % int(grid_size.x), 
			randi() % int(grid_size.y)
		)
		if get_entity_of_cell(temp_pos) == null:
			random_grid_pos = temp_pos
			has_random_pos = true

	place_entity(entity, random_grid_pos)

func move_entity_in_direction(entity: Node2D, direction: Vector2) -> void:
	var oldPosition: Vector2 = world_to_map(entity.global_position)
	
	if  not is_within_bounds(oldPosition):
		return
	
	var newPosition: Vector2 = oldPosition + direction
	newPosition.x = clamp(newPosition.x, 0, grid_size.x - 1)
	newPosition.y = clamp(newPosition.y, 0, grid_size.y - 1)
	
	var entityOfNewCell: Node2D = get_entity_of_cell(newPosition)
	if entityOfNewCell != null:
		if entityOfNewCell.is_in_group("Player"):
			setup_grid()
			emit_signal("moved_into_death")
		elif entityOfNewCell.is_in_group("Food"):
			emit_signal("moved_into_food", entityOfNewCell, entity)
	
	if is_within_bounds(newPosition):
		set_entity_in_cell(null, oldPosition)
		place_entity(entity, newPosition)

func move_entity_to_position(entity: Node2D, new_pos: Vector2) -> void:
	var old_grid_pos: Vector2 = world_to_map(entity.position)
	var new_grid_pos: Vector2 = world_to_map(new_pos)
	
	set_entity_in_cell(null, old_grid_pos)
	place_entity(entity, new_grid_pos)
	entity.global_position = _to_global(new_grid_pos) + cell_size/2

func _to_global(grid_pos: Vector2) -> Vector2:
	if is_within_bounds(grid_pos):
		return grid_pos * cell_size
	return Vector2.ZERO

func world_to_map(world_pos: Vector2) -> Vector2:
	var grid_pos = Vector2(floor(world_pos.x / cell_size.x), floor(world_pos.y / cell_size.y))
	grid_pos.x = clamp(grid_pos.x, 0, grid_size.x - 1)
	grid_pos.y = clamp(grid_pos.y, 0, grid_size.y - 1)
	return grid_pos
