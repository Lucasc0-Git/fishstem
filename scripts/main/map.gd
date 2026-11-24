extends Node2D
class_name Map


signal level_changed(to: Levels)

enum Levels {
	TestingMap,
	Lvl1,
	Lvl2,
	Lvl3,
	
}

@onready var level_nodes: Dictionary = {
	Levels.TestingMap: $TestingMap2,
	Levels.Lvl1: $Lvl1,
	Levels.Lvl2: $Lvl2,
	Levels.Lvl3: $Lvl3
}

var current_level: Levels = Levels.TestingMap


func change_level(to: Levels) -> void:
	var level_node: Node = level_nodes.get(to, null)
	if not level_node: return
	
	for node in level_nodes:
		if node == level_node:
			node.visible = true
		else:
			node.visible = false
	
	current_level = to
	level_changed.emit(to)

func spawn_ice(pos: Vector2, _scale: Vector2, _rotation_deg: float) -> void:
	var level_node: Node2D = level_nodes.get(current_level, null)
	if not level_node: return
	
	var ice: IceGameObject = IceGameObject.new()
	ice.global_position = pos
	ice.scale = _scale
	ice.rotation_degrees = _rotation_deg
	level_node.add_child(ice)
