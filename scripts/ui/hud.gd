extends CanvasLayer
class_name HUD



@onready var dna_label: Label = $Control/DNALabel


func _ready() -> void:
	while not GameManager.game_loaded:
		await get_tree().process_frame
	
	if dna_label:
		dna_label.text = "DNA: %s" % [GameManager.dna]
	
	GameManager.dna_changed.connect(_on_dna_changed)

func _on_dna_changed() -> void:
	if not dna_label: return
	dna_label.text = "DNA: %s" % [GameManager.dna]
