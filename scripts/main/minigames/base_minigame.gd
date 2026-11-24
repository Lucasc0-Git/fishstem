extends Node2D
class_name Minigame

signal completed(success: bool)

func start_minigame(_config: Dictionary = {}) -> void:
	pass

func cleanup() -> void:
	queue_free()
