extends Node

signal resource_updated(resource_name: String, new_amount: int)

var resources: Dictionary


func add_resource(resource_name, amount):
	if (amount < 0):
		return
	if (!resources.has(resource_name)):
		resources[resource_name] = 0
		
	resources[resource_name] += amount
	resource_updated.emit(resource_name, resources[resource_name])


func try_spend_resourse(resource_name, amount):
	if (amount < 0):
		return false
	if (!resources.has(resource_name)):
		return false
	if (resources[resource_name] < amount):
		return false
	resources[resource_name] -= amount
	resource_updated.emit(resources[resource_name])
	return true
