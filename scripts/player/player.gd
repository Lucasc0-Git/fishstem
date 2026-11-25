extends Node2D
class_name Player

@export var move_speed: float = 700

@onready var camera: Camera2D = $Camera2D

var main: Main = null
var input_dir: Vector2 = Vector2.ZERO

func _ready() -> void:
	MinigameManager.minigame_finished.connect(_on_minigame_finished)
	
	while not GameManager.game_loaded:
		await get_tree().process_frame
	
	main = GameManager.main

func _process(_delta: float) -> void:
	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

func _physics_process(delta: float) -> void:
	if not GameManager.minigame_active:
		global_position += input_dir.normalized() * (move_speed / camera.zoom.x) * delta
	

func _input(event: InputEvent) -> void:
	if not main: return
	
	# Zoom
	if main.hud.shop_visible: return
	if event.is_action_pressed("zoom"):
		camera.zoom += Vector2(0.2, 0.2)
		if camera.zoom >= Vector2(4, 4):
			camera.zoom = Vector2(4, 4)
	elif event.is_action_pressed("unzoom"):
		camera.zoom -= Vector2(0.2, 0.2)
		if camera.zoom <= Vector2(1, 1):
			camera.zoom = Vector2(1, 1)

func _on_minigame_finished(_success: bool, _rewards: Dictionary) -> void:
	camera.make_current()
