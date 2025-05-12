extends Node

var _inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_current_item_changed(Inventory.current_item)
	Inventory.current_item_changed.connect(_on_current_item_changed)
	Inventory.items_updated.connect(_on_items_updated)
	

func _on_current_item_changed(item: InventoryItem):
	$Texture.texture = item.sprite
	$ItemName.text = item.name
	$RarityBorder.get_theme_stylebox("panel").border_color = Colors.rarity_colors[item.rarity]
	
	if (item.name == "Empty"):
		$Amount.text = ""
	else:
		$Amount.text = str(Inventory.items[item])
		
		
func _on_items_updated(item: InventoryItem, new_amount: int):
	if (Inventory.current_item != item):
		return
	$Amount.text = str(new_amount)
