extends Area2D


@export var _highlight_scene: PackedScene
var _highlight: Node2D


var _interactable_list = []


func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func _process(_delta):
	if (_highlight == null):
		_highlight = _highlight_scene.instantiate()
		add_child(_highlight)
	
	if (len(_interactable_list) == 0):
		_highlight.visible = false
		return
	
	_highlight.visible = true
	_highlight.global_position = _get_priority_interactable().global_position


func interact():
	if (len(_interactable_list) == 0):
		return
	_get_priority_interactable().interact()


func _get_priority_interactable():
	var priority_interactable = _interactable_list[0]
	var min_angle = abs(get_angle_to(_interactable_list[0].global_position))
	for interactable in _interactable_list:
		var angle = abs(get_angle_to(interactable.global_position))
		if (angle < min_angle):
			priority_interactable = interactable
			min_angle = angle
	
	return priority_interactable


func _on_area_entered(area):
	if (area is InteractableComponent && area not in _interactable_list):
		_interactable_list.append(area)


func _on_area_exited(area):
	if (area in _interactable_list):
		_interactable_list.erase(area)
