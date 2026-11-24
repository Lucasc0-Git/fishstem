extends Control




func _ready() -> void:
	visible = false

func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("pause"):
		pause_game()

func pause_game() -> void:
	get_tree().paused = true
	show()

func unpause_game() -> void:
	hide()
	get_tree().paused = false


func _on_resume_button_pressed() -> void:
	unpause_game()

func _on_menu_button_pressed() -> void:
	SceneTransition.change_scene_to_file(Constants.START_SCENE_FILEPATH)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
