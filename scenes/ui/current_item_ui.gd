extends Node

var _inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	_inventory = Inventory
	_on_current_item_changed(_inventory.current_item)
	_inventory.current_item_changed.connect(_on_current_item_changed)
	_inventory.items_updated.connect(_on_items_updated)
	

func _on_current_item_changed(item: InventoryItem):
	$Texture.texture = item.sprite
	$ItemName.text = item.name
	
	if (item.name == "Empty"):
		$Amount.text = ""
	else:
		$Amount.text = str(_inventory.items[item])
		
		
func _on_items_updated(item: InventoryItem, new_amount: int):
	if (_inventory.current_item != item):
		return
	$Amount.text = str(new_amount)
