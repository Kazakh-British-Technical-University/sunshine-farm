extends Node2D

var plant: Plant
var grow_phase: int


# Called when the node enters the scene tree for the first time.
func _ready():
	TimeManager.day_started.connect(_on_day_ended)
	$InteractableComponent.interacted.connect(_on_interacted)


func _on_interacted():
	if (plant == null):
		_plant_seed()
	else:
		_remove_plant()
	
	
func _plant_seed():	
	var current_item = Inventory.current_item
	if (current_item is not SeedItem):
		return
	
	if (!Inventory.try_spend_item(current_item, 1)):
		return
		
	plant = load(current_item.plant_resource_path)
	$PlantSprite.texture = plant.sprite_seed
	SFX.play_effect(SFX.INTERACT)
	
	
func _remove_plant():
	if (grow_phase < plant.days_to_grow || grow_phase > plant.days_to_grow + plant.days_to_wither):
		print("plant destroyed")
	else:
		_collect_plant()
		
	plant = null
	$PlantSprite.texture = null
	grow_phase = 0
	SFX.play_effect(SFX.INTERACT)


func _collect_plant():
	var inventory = Inventory
	if (inventory == null):
		return
		
	var product = load(plant.product_resource_path)
	inventory.add_item(product, plant.product_amount)
	
	
func _on_day_ended():
	if (plant == null):
		return
		
	grow_phase += 1
	if (grow_phase == plant.days_to_grow):
		$PlantSprite.texture = plant.sprite_mature
	if (grow_phase == plant.days_to_grow + plant.days_to_wither):
		$PlantSprite.texture = plant.sprite_withered
	
	
	
