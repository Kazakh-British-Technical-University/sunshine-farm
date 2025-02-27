extends Node2D

var _sound_effect = load("res://assets/audio/clothBelt2.ogg")

# Called when the node enters the scene tree for the first time.
func _ready():
	$InteractableComponent.interacted.connect(_on_interacted)
	
	
func _on_interacted(origin):
	var inventory = Globals.inventory
	if (inventory == null):
		return
		
	var current_item = inventory.current_item
	if (current_item == Globals.inventory.empty_item || current_item == Globals.inventory.gold_item):
		return
		
	if (inventory.try_spend_item(current_item, 1)):
		Globals.sfx.play_effect(_sound_effect)
		inventory.add_item(Globals.inventory.gold_item, current_item.price)
