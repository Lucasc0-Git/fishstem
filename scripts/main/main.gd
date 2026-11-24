extends Node2D
class_name Main

@onready var map: Map = $Map



func _ready() -> void:
	await get_tree().process_frame
	GameManager.game_loaded = true
	
	MinigameManager.minigame_started.connect(_on_minigame_started)
	MinigameManager.minigame_finished.connect(_on_minigame_finished)

func _on_minigame_started() -> void:
	map.hide()

func _on_minigame_finished(_success: bool) -> void:
	map.show()
