extends Node2D
class_name Player

@export var move_speed: float = 350

var input_dir: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

func _physics_process(delta: float) -> void:
	global_position += input_dir.normalized() * move_speed * delta
	
	

func _input(_event: InputEvent) -> void:
	pass
