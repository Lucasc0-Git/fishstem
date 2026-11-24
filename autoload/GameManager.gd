extends Node


var main: Main = null
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

func start_game(_save_name: String = "save not made :P") -> void:
	print("starting the game")
	await SceneTransition.change_scene_to_file(Constants.MAIN_SCENE_FILEPATH)
	get_tree().paused = false
