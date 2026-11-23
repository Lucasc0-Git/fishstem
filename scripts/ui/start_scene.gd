extends CanvasLayer
class_name StartScene



func _on_start_game_button_pressed() -> void:
	GameManager.start_game()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
