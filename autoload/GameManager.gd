extends Node

var main: Main = null
var main_scene_filepath: String = "res://scenes/main/Main.tscn"
var game_loaded: bool = false

var dna: int = 0

signal dna_changed()


func add_dna(amount: int) -> void:
	if amount < 0: return
	dna += amount
	dna_changed.emit()

func remove_dna(amount: int) -> void:
	if amount < 0: return
	dna += amount
	dna_changed.emit()

func set_dna(amount: int) -> void:
	if amount < 0: return
	dna = amount
	dna_changed.emit()

func start_game() -> void:
	SceneTransition.change_scene_to_file(main_scene_filepath)
