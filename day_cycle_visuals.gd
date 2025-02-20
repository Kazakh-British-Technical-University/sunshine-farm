extends CanvasModulate

@export var day_color: Color
@export var evening_color: Color
@export var night_color: Color


func _ready():
	Globals.time_manager.day_started.connect(_on_day_stared)
	Globals.time_manager.evening_started.connect(_on_evening_stared)
	Globals.time_manager.night_started.connect(_on_night_stared)
	
	
func _on_day_stared():
	_interpolate_color(night_color, day_color)
	

func _on_evening_stared():
	_interpolate_color(day_color, evening_color)
	
	
func _on_night_stared():
	_interpolate_color(evening_color, night_color)
		
		
func _interpolate_color(start_color, target_color):
	var t = 0
	while (t < 1):
		color = lerp(start_color, target_color, smoothstep(0, 1, t))
		t += get_process_delta_time()
		await get_tree().process_frame
