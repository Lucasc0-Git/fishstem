extends Node2D
class_name Minigame

@export var rewards: Dictionary = {"dna": 10}

signal completed(success: bool, rewards: Dictionary)

func start_minigame(_config: Dictionary = {}) -> void:
	pass

func cleanup() -> void:
	queue_free()


func _on_back_button_pressed() -> void:
	completed.emit(false, {})
