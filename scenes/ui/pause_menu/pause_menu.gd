extends CanvasLayer


func _ready():
	visible = false
	$%ButtonContinue.pressed.connect(_on_continue)
	$%ButtonExit.pressed.connect(_on_exit)


func _process(delta):
	if (Input.is_action_just_pressed("pause")):
		_switch_active()


func _switch_active():
	var is_active = visible
	visible = !is_active
	get_tree().paused = !is_active
	
	if (!is_active):
		$%ButtonContinue.grab_focus()


func _on_continue():
	_switch_active()


func _on_exit():
	get_tree().quit()
