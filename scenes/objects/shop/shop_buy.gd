extends Node2D


@export var item_for_sale: InventoryItem

var _sound_effect = load("res://assets/audio/handleCoins.ogg")


# Called when the node enters the scene tree for the first time.
func _ready():
	$InteractableComponent.interacted.connect(_on_interacted)
	$Visuals/ItemSprite.texture = item_for_sale.sprite
	
	
func _on_interacted():		
	if (Inventory.try_spend_item(Inventory.gold_item, item_for_sale.price)):
		SFX.play_effect(_sound_effect)
		Inventory.add_item(item_for_sale, 1)
