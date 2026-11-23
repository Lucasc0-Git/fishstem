extends Node

var main: Main = null
var main_scene_filepath: String = "res://scenes/main/Main.tscn"


func start_game() -> void:
	SceneTransition.change_scene_to_file(main_scene_filepath)
