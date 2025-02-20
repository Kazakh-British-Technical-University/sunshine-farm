extends Node
class_name TimeManager

signal day_ended
signal evening_started

@export var day_duration: float
@export var evening_duration: float

var _timer: Timer

func _enter_tree():
	Globals.time_manager = self
	
	
func _ready():
	_timer = $Timer
	_start_day()
	
	
func _start_day():
	_timer.wait_time = day_duration
	_timer.timeout.connect(_start_evening)
	_timer.start()
	

func _start_evening():
	evening_started.emit()
	print("evening started")
	_timer.wait_time = evening_duration
	_timer.timeout.disconnect(_start_evening)
	_timer.timeout.connect(_end_day)
	_timer.start()
	
	
func _end_day():
	day_ended.emit()
	_timer.timeout.disconnect(_end_day)
	print("day ended")
	_start_day()
