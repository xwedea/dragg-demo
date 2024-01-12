extends Node

@onready var world := get_tree().root.get_node("World3D") as World
@onready var timer_label := get_node("ControlTopRight/ControlTimer/TimerLabel") as Label
@onready var count_label := get_node("ControlTopRight/ControlCoin/CoinLabel") as Label


var time := 0.0


func _process(delta):
	_update_timer(delta)
	count_label.text = str(world.coins_collected)	


func _update_timer(delta):
	time += delta
	var milliseconds = fmod(time, 1) * 100
	var seconds = fmod(time, 60)
	var minutes = fmod(time, 3600) / 60

	var minutes_formatted = "%02d" % minutes
	var seconds_formatted = "%02d" % seconds
	var _milliseconds_formatted = "%02d" % milliseconds

	timer_label.text = minutes_formatted + ":" + seconds_formatted # + milliseconds_formatted




func _on_pause_button_pressed():
	print("x")
	get_tree().change_scene_to_file("res://title_screen/title_world.tscn")

