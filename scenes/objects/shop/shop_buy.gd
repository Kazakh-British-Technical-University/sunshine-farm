extends Node2D


@export var item_for_sale: InventoryItem

var _gold = load("res://resources/items/gold.tres")
var _sound_effect = load("res://assets/audio/handleCoins.ogg")


# Called when the node enters the scene tree for the first time.
func _ready():
	$InteractableComponent.interacted.connect(_on_interacted)
	$Visuals/ItemSprite.texture = item_for_sale.sprite
	
	
func _on_interacted(origin):
	var inventory = origin.get_node("InventoryComponent")
	if (inventory == null):
		return
		
	if (inventory.try_spend_item(_gold, item_for_sale.price)):
		Globals.sfx.play_effect(_sound_effect)
		inventory.add_item(item_for_sale, 1)
