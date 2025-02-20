extends Area2D
class_name InteractableComponent

signal interacted(origin)

func interact(origin):
	interacted.emit(origin)
