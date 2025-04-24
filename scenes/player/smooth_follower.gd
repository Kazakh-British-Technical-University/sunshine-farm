extends Node2D

@export var target: Node2D

var _last_position: Vector2


func _process(_delta):
	global_position = lerp(_last_position, target.global_position, 0.1)
	_last_position = global_position
