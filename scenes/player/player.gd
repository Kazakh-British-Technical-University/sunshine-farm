extends CharacterBody2D
class_name Player


@export var MAX_SPEED = 300.0


var _is_control_locked = false;


func _process(_delta):
	if (_is_control_locked):
		return
		
	if ($InventoryComponent != null):
		_switch_item()
	if ($InteractorComponent != null):
		_interact()
	_move()


func _switch_item():
	if (Input.is_action_just_pressed("switch_item_left")):
		$InventoryComponent.switch_item(-1)
	elif (Input.is_action_just_pressed("switch_item_right")):
		$InventoryComponent.switch_item(1)


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
