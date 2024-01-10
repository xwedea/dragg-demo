extends Panel

@onready var milliseconds_label := get_node("MillisecondsLabel") as Label
@onready var seconds_label := get_node("SecondsLabel") as Label
@onready var minutes_label := get_node("MinutesLabel") as Label
@onready var timer_label := get_node("TimerLabel") as Label

var time: float = 0
var milliseconds: int = 0
var seconds: int = 0
var minutes: int = 0

func _ready():
	pass


func _process(delta):
	time += delta
	milliseconds = fmod(time, 1) * 100
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60

	var minutes_formatted = "%02d:" % minutes
	var seconds_formatted = "%02d." % seconds
	var milliseconds_formatted = "%02d" % milliseconds

	timer_label.text = minutes_formatted + seconds_formatted + milliseconds_formatted
