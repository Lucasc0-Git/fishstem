extends CanvasLayer
class_name HUD


@onready var dna_label: Label = %DNALabel
@onready var shop: Shop = $Shop

@onready var debug_overlay: Control = $DEBUGOverlay


func _ready() -> void:
	while not GameManager.game_loaded:
		await get_tree().process_frame
	
	shop.visible = false
	
	if dna_label:
		dna_label.text = "DNA: %s" % [GameManager.dna]
	
	GameManager.dna_changed.connect(_on_dna_changed)

func _on_dna_changed() -> void:
	if not dna_label: return
	dna_label.text = "DNA: %s" % [GameManager.dna]

func _on_shop_button_toggled(toggled_on: bool) -> void:
	shop.visible = toggled_on

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("DEBUG_toggle_debug_overlay"):
		debug_overlay.visible = !debug_overlay.visible
