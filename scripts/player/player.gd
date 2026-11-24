extends Node2D
class_name Player

@export var move_speed: float = 700

@onready var camera: Camera2D = $Camera2D


var input_dir: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

func _physics_process(delta: float) -> void:
	global_position += input_dir.normalized() * (move_speed / camera.zoom.x) * delta
	
	

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("zoom"):
		camera.zoom += Vector2(0.2, 0.2)
		if camera.zoom >= Vector2(4, 4):
			camera.zoom = Vector2(4, 4)
	
	elif event.is_action_pressed("unzoom"):
		camera.zoom -= Vector2(0.2, 0.2)
		if camera.zoom <= Vector2(1, 1):
			camera.zoom = Vector2(1, 1)
