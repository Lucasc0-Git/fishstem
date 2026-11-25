extends Node2D
class_name GameObject

signal interacted()

@export var starts_minigame: bool = false
@export var free_after_finishing_minigame: bool = true
@export var minigame_scene: PackedScene = null
@export var difficulty_config: Dictionary = {}

func _ready() -> void:
	interacted.connect(_on_interacted)

func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact"):
		interacted.emit()

func _on_interacted() -> void:
	if not starts_minigame: return
	MinigameManager.launch(minigame_scene)
	var minigame_finished_args: Array = await MinigameManager.minigame_finished
	if minigame_finished_args[0]:
		queue_free()
