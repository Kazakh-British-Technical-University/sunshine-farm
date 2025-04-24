extends CharacterBody2D
class_name Player


@export var MAX_SPEED = 100.0


var _is_control_locked = false;
var _spawn_point;
	
	
func _ready():
	_spawn_point = global_position
	TimeManager.night_started.connect(_on_night_started)
	TimeManager.day_started.connect(_on_day_started)


func _on_night_started():
	_is_control_locked = true
	
	
func _on_day_started():
	_is_control_locked = false
	global_position = _spawn_point


func _process(_delta):
	if (_is_control_locked):
		return
	
	if ($InteractorComponent != null):
		_interact()
	_move()
	_switch_item()


func _switch_item():
	if (Input.is_action_just_pressed("switch_item_left")):
		Inventory.switch_item(-1)
	elif (Input.is_action_just_pressed("switch_item_right")):
		Inventory.switch_item(1)


func _interact():
	if (Input.is_action_just_pressed("interact")):
		$InteractorComponent.interact()


func _move():	
	var movement_vector = _get_movement_vector()
	var direction = movement_vector.normalized()
	
	if (direction != Vector2.ZERO):
		$InteractorComponent.rotation = direction.angle()
	
	velocity = direction * MAX_SPEED
	move_and_slide()


func _get_movement_vector() -> Vector2:	
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)


func win():
	$Sprite.play("win")
	_is_control_locked = true
