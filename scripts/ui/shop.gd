extends Control
class_name Shop


@onready var flora_container: ScrollContainer = %Flora
@onready var fauna_container: ScrollContainer = %Fauna
@onready var upgrades_container: ScrollContainer = %Upgrades
@onready var containers: Array[Node] = [
	flora_container,
	fauna_container,
	upgrades_container
]

@onready var tab_container: TabContainer = $PanelContainer/MarginContainer/VBoxContainer/TabContainer

var shop_items: Dictionary[String, ShopItem] = {}

func _ready() -> void:
	while not GameManager.game_loaded:
		await get_tree().process_frame
	
	tab_container.current_tab = 0
	
	_populate_shop_items_list()

func _populate_shop_items_list() -> void:
	for container in containers:
		for node in GameManager.get_all_children(container):
			if node is ShopItem:
				
				
				shop_items[node.id] = node
				ShopManager.register_shop_item(node.id)
				if not node.request_buy.is_connected(_on_player_purchase_requested):
					node.request_buy.connect(_on_player_purchase_requested)

func _on_player_purchase_requested(id: String, base_cost: int) -> void:
	if not id in ShopManager.available_purchases:
		return
	if base_cost > GameManager.dna:
		return
	GameManager.remove_dna(base_cost)
	ShopManager.buy_shop_item(id)
	if id in shop_items:
		var node: ShopItem = shop_items[id]
		shop_items.erase(id)
		node.queue_free()
