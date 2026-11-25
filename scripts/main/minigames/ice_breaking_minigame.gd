extends Minigame
class_name IceBreakingMinigame


@onready var ice_layer: TileMapLayer = $TileMapLayer

var ice_health: Dictionary = {} # Vector2i as tile coords : health
var total_ice_tiles: int = 0

const TILE_INTACT = Vector2(1, 0)
const TILE_HALF_BROKEN = Vector2(2, 0)
const TILE_BROKEN = Vector2(0, 0)

func start_minigame(config: Dictionary = {}) -> void:
	_register_ice_tiles(config)

func _register_ice_tiles(config: Dictionary = {}) -> void:
	var used_cells: Array[Vector2i] = ice_layer.get_used_cells()
	total_ice_tiles = used_cells.size()
	
	var cell_health: int = 3
	if config.has("ice_health"):
		cell_health = config.get("ice_health", 3)
	
	for cell in used_cells:
		ice_health[cell] = cell_health

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("interact") or (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
		var local_pos: Vector2 = ice_layer.to_local(get_global_mouse_position())
		var cell_coords: Vector2i = ice_layer.local_to_map(local_pos)
		
		if not ice_health.has(cell_coords):
			return
		
		ice_health[cell_coords] -= 1
		_update_tile_visuals(cell_coords)
		get_viewport().set_input_as_handled()

func _update_tile_visuals(cell: Vector2i) -> void:
	var hp: int = ice_health[cell]
	
	if hp <= 0:
		ice_health.erase(cell)
		ice_layer.erase_cell(cell)
		
		_check_win_condition()
	elif hp == 2:
		ice_layer.set_cell(cell, 1, TILE_HALF_BROKEN)
	elif hp == 1:
		ice_layer.set_cell(cell, 1, TILE_BROKEN)

func _check_win_condition() -> void:
	if ice_health.is_empty():
		completed.emit(true, rewards)

func cleanup() -> void:
	queue_free()
