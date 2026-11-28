extends Node2D
class_name Main

@onready var map: Map = $Map
@onready var hud: HUD = $HUD


func _ready() -> void:
	GameManager.main = self
	
	
	MinigameManager.minigame_started.connect(_on_minigame_started)
	MinigameManager.minigame_finished.connect(_on_minigame_finished)
	await get_tree().process_frame
	GameManager.game_loaded = true
	

func _input(event: InputEvent) -> void:
	
	
	
	
	if event.is_action_pressed("DEBUG_add_dna"):
		GameManager.add_dna(50)

func _on_minigame_started() -> void:
	map.hide()

func _on_minigame_finished(_success: bool, rewards: Dictionary) -> void:
	map.show()
	
	for reward in rewards:
		if reward == "dna":
			GameManager.add_dna(rewards[reward])
