extends Node

signal current_item_changed(item: InventoryItem)
signal items_updated(item: InventoryItem, new_amount: int)

var items: Dictionary
var current_item: InventoryItem


func _ready():
	items[load("res://resources/item/gold.tres")] = 1
	items[load("res://resources/item/seed1.tres")] = 1


func switch_item(offset: int):
	var current_index = items.keys().find(current_item)
	var next_index = (current_index + offset) % len(items.keys())
	
	current_item = items.keys()[next_index]
	current_item_changed.emit(current_item)
	print(current_item.name)


func add_item(item, amount):
	if (amount < 0):
		return
	if (!items.has(item)):
		items[item] = 0
		
	items[item] += amount
	items_updated.emit(item, items[item])


func try_spend_item(item, amount):
	if (amount < 0):
		return false
	if (!items.has(item)):
		return false
	if (items[item] < amount):
		return false
	items[item] -= amount
	items_updated.emit(item, items[item])
	
	if (items[item] == 0):
		items.erase(item)
	
	return true
