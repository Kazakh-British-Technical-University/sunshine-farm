extends Node2D

var plant: Plant
var grow_phase: int
var _sound_effect = load("res://assets/audio/handleSmallLeather2.ogg")


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.time_manager.day_started.connect(_on_day_ended)
	
	if ($InteractableComponent != null):
		$InteractableComponent.interacted.connect(_on_interacted)


func _on_interacted(origin):
	if (plant == null):
		_plant_seed()
	else:
		_remove_plant()
	
	
func _plant_seed():
	var inventory = Globals.inventory
	if (inventory == null):
		return
	
	var current_item = inventory.current_item
	if (current_item is not SeedItem):
		return
	
	if (!inventory.try_spend_item(current_item, 1)):
		return
		
	plant = load(current_item.plant_resource_path)
	$PlantSprite.texture = plant.sprite_seed
	Globals.sfx.play_effect(_sound_effect)
	
	
func _remove_plant():
	if (grow_phase < plant.days_to_grow || grow_phase > plant.days_to_grow + plant.days_to_wither):
		print("plant destroyed")
	else:
		_collect_plant()
		
	plant = null
	$PlantSprite.texture = null
	grow_phase = 0
	Globals.sfx.play_effect(_sound_effect)


func _collect_plant():
	var inventory = Globals.inventory
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
	
	
	
