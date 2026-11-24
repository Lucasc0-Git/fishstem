extends Node


signal minigame_finished(success: bool)

var active_minigame: Minigame = null

func launch(scene: PackedScene, config: Dictionary = {}) -> void:
	if active_minigame != null or scene == null: return
	
	active_minigame = scene.instantiate() as Minigame
	get_tree().root.add_child(active_minigame)
	
	active_minigame.completed.connect(_on_minigame_completed)
	active_minigame.start_minigame(config)

func _on_minigame_completed(success: bool) -> void:
	minigame_finished.emit(success)
	active_minigame.cleanup()
	active_minigame = null
