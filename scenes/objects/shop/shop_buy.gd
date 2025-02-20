extends Node2D


@export var item_for_sale: InventoryItem

var _gold = load("res://resources/item/gold.tres")


# Called when the node enters the scene tree for the first time.
func _ready():
	$InteractableComponent.interacted.connect(_on_interacted)
	
	
func _on_interacted(origin):
	var inventory = origin.get_node("InventoryComponent")
	if (inventory == null):
		return
		
	if (inventory.try_spend_item(_gold, item_for_sale.price)):
		inventory.add_item(item_for_sale, 1)
