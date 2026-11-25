extends CanvasLayer
class_name StartScene

@onready var quit_button: Button = $Control/VBoxContainer/QuitButton

func _ready() -> void:
	if OS.get_name() == "Web":
		quit_button.visible = false

func _on_start_game_button_pressed() -> void:
	GameManager.start_game()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
