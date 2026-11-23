extends Node2D
class_name Main




func _ready() -> void:
	await get_tree().process_frame
	GameManager.game_loaded = true
