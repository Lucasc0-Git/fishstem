extends Control
class_name Shop


@onready var flora_container: ScrollContainer = %Flora
@onready var fauna_container: ScrollContainer = %Fauna
@onready var upgrades_container: ScrollContainer = %Upgrades

var shop_items: Dictionary[String, ShopItem] = {}

func _ready() -> void:
	while not GameManager.game_loaded:
		await get_tree().process_frame
	
	_populate_shop_items_list()

func _populate_shop_items_list() -> void:
	for node in get_all_children(flora_container):
		if node is ShopItem:
			shop_items[node.id] = node
			GameManager.main.available_purchases[node.id] = true
			if not node.request_buy.is_connected(_on_player_purchase_requested):
				node.request_buy.connect(_on_player_purchase_requested)

func _on_player_purchase_requested(id: String, base_cost: int) -> void:
	if not id in GameManager.main.available_purchases:
		return
	if base_cost > GameManager.dna:
		return
	GameManager.remove_dna(base_cost)
	GameManager.main.available_purchases.erase(id)
	GameManager.main.player_purchased[id] = true
	if id in shop_items:
		var node: ShopItem = shop_items[id]
		shop_items.erase(id)
		node.queue_free()

func get_all_children(node: Node) -> Array[Node]:
	var nodes: Array[Node] = []
	for child in node.get_children():
		nodes.append(child)
		nodes.append_array(get_all_children(child))
	return nodes
