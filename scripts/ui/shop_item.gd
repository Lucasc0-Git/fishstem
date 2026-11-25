extends Control
class_name ShopItem

@export var icon: Texture2D = null:
	set(value):
		icon = value
		_set_look()
@export var id: String = ""
@export var description: String = "":
	set(value):
		description = value
		_set_look()
@export var base_cost: int = 0
@export var disabled_color: Color = Color(1, 1, 1)


@onready var icon_rect: TextureRect = %Icon
@onready var description_label: RichTextLabel = %Description
@onready var buy_button: Button = %BuyButton

signal request_buy(id: String, base_cost: int)

func _ready() -> void:
	_set_look()

func _set_look() -> void:
	if not is_node_ready():
		return
	
	if icon != null:
		icon_rect.texture = icon
		icon_rect.custom_minimum_size = Vector2(icon_rect.size.y, icon_rect.size.y)
	if description != "":
		description_label.text = description

func _on_buy_button_pressed() -> void:
	request_buy.emit(id, base_cost)

func _process(delta: float) -> void:
	if GameManager.dna < base_cost:
		modulate = disabled_color
		buy_button.disabled = true
	else:
		modulate = Color(1, 1, 1)
		buy_button.disabled = false
