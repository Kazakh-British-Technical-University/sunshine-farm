extends Node2D

var plant: Plant
var grow_phase: int


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.time_manager.day_started.connect(_on_day_ended)
	
	if ($InteractableComponent != null):
		$InteractableComponent.interacted.connect(_on_interacted)


func _on_interacted(origin):
	if (plant == null):
		_plant_seed(origin)
	else:
		_remove_plant(origin)
	
	
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
	
	
func _remove_plant(origin):
	if (grow_phase < plant.days_to_grow || grow_phase > plant.days_to_grow + plant.days_to_wither):
		print("plant destroyed")
	else:
		_collect_plant(origin)
		
	plant = null
	$PlantSprite.texture = null
	grow_phase = 0


func _collect_plant(origin):
	var inventory = origin.get_node("InventoryComponent")
	if (inventory == null):
		return
		
	inventory.add_item(plant.product, plant.product_amount)
	
	
func _on_day_ended():
	if (plant == null):
		return
		
	grow_phase += 1
	if (grow_phase == plant.days_to_grow):
		$PlantSprite.texture = plant.sprite_mature
	if (grow_phase == plant.days_to_grow + plant.days_to_wither):
		$PlantSprite.texture = plant.sprite_withered
	
	
	
