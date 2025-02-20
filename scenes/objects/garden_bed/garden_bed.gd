extends Node2D

var plant: Plant


# Called when the node enters the scene tree for the first time.
func _ready():
	if ($InteractableComponent != null):
		$InteractableComponent.interacted.connect(_on_interacted)


func _on_interacted(origin):
	if (plant == null):
		_plant_seed(origin)
	else:
		_collect_plant(origin)
	
	
func _plant_seed(origin):
	var inventory = origin.get_node("InventoryComponent")
	if (inventory == null):
		return
	
	var current_item = inventory.current_item
	if (current_item is not SeedItem):
		return
	
	if (!inventory.try_spend_item(current_item, 1)):
		return
		
	plant = current_item.grows_into
	$PlantSprite.texture = plant.sprite_seed
	
	
func _collect_plant(origin):
	pass
