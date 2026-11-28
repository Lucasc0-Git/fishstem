extends Node


var available_purchases: Dictionary[String, bool] = {}
var player_purchased: Dictionary[String, bool] = {}


signal shop_item_purchased(id: String)

func register_shop_item(id: String) -> void:
	if not available_purchases.has(id):
		available_purchases[id] = true

func buy_shop_item(id: String) -> void:
	if available_purchases.has(id) and not player_purchased.has(id):
		player_purchased[id] = true
		shop_item_purchased.emit(id)

func has_upgrade(id: String) -> bool:
	return player_purchased.has(id)

"""
Available upgrades:
	- Flora:
		Kelp
		
	- Fauna:
		Fsh
		
	- Upgrades:
		
"""
