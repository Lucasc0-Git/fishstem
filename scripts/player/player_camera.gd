extends Camera2D

@export var pan_speed: float = 1.0

var is_dragging: bool = false:
	set(value):
		is_dragging = value
		if value:
			position_smoothing_enabled = false
		else:
			position_smoothing_enabled = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("grab_map"):
		is_dragging = event.pressed
		get_viewport().set_input_as_handled()
	
	elif event is InputEventMouseMotion and is_dragging:
		$".".global_position -= (event.relative * pan_speed) / zoom
		get_viewport().set_input_as_handled()
