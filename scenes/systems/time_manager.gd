extends Node
class_name TimeManager

signal day_started
signal evening_started
signal night_started

@export var day_duration: float
@export var evening_duration: float
@export var night_duration: float

var _timer: Timer

func _enter_tree():
	Globals.time_manager = self
	
	
func _ready():
	_timer = $Timer
	_start_day()
	
	
func _start_day():
	day_started.emit()
	_timer.wait_time = day_duration
	if (_timer.timeout.is_connected(_start_day)):
		_timer.timeout.disconnect(_start_day)
	_timer.timeout.connect(_start_evening)
	_timer.start()
	

func _start_evening():
	evening_started.emit()
	_timer.wait_time = evening_duration
	_timer.timeout.disconnect(_start_evening)
	_timer.timeout.connect(_start_night)
	_timer.start()
	
	
func _start_night():
	night_started.emit()
	_timer.wait_time = night_duration
	_timer.timeout.disconnect(_start_night)
	_timer.timeout.connect(_start_day)
	_timer.start()
