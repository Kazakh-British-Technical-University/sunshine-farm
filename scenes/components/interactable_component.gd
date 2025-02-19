extends Area2D
class_name InteractableComponent

signal interacted	

func interact():
	interacted.emit()
