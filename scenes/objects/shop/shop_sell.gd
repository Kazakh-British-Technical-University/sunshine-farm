extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$InteractableComponent.interacted.connect(_on_interacted)
	
	
func _on_interacted():
	var current_item = Inventory.current_item
	if (current_item == Inventory.empty_item || current_item == Inventory.gold_item):
		return
		
	if (Inventory.try_spend_item(current_item, 1)):
		SFX.play_effect(SFX.SELL)
		Inventory.add_item(Inventory.gold_item, current_item.price)
