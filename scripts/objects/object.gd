extends Node2D
class_name GameObject

signal interacted()

@export var starts_minigame: bool = false
@export var minigame_scene: PackedScene = null
@export var difficulty_config: Dictionary = {}

func _ready() -> void:
	interacted.connect(_on_interacted)

func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact"):
		interacted.emit()

func _on_interacted() -> void:
	print("interacted")
	if not starts_minigame: return
