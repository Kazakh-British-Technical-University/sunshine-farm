extends Area2D

@export var text: String
var _dialogue_shown = false


func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	$CanvasLayer/DialogueBox.set_text(text)


func _process(delta):
	if (!_dialogue_shown):
		return
	
	$CanvasLayer/DialogueBox.position = \
		$DialogueBoxOrigin.get_global_transform_with_canvas().get_origin() \
		- ($CanvasLayer/DialogueBox.size / 2)

func _on_body_entered(body):
	if (body is Player and !_dialogue_shown):
		_show_dialogue(true)


func _on_body_exited(body):
	if (body is Player and _dialogue_shown):
		_show_dialogue(false)
	
	
func _show_dialogue(flag):
	_dialogue_shown = flag
	$CanvasLayer/DialogueBox.visible = flag
	
