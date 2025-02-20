extends Node2D


var _gold = load("res://resources/item/gold.tres")
var _empty = load("res://resources/item/empty.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	$InteractableComponent.interacted.connect(_on_interacted)
	
	
func _on_interacted(origin):
	var inventory = origin.get_node("InventoryComponent")
	if (inventory == null):
		return
		
	var current_item = inventory.current_item
	if (current_item == _empty && current_item != _gold):
		return
		
	if (inventory.try_spend_item(current_item, 1)):
		inventory.add_item(_gold, current_item.price)
