extends Node

@onready var world := get_tree().root.get_node("World3D") as World
@onready var player := world.get_node("Player") as BaseCharacter
@onready var control_sticks := get_node("ControlSticks") as ControlSticks
@onready var timer_label := get_node("ControlTopCenter/ControlTimer/TimerLabel") as Label
@onready var count_label := get_node("ControlTopCenter/ControlCoin/CoinLabel") as Label
@onready var pause_label := get_node("ControlTopCenter/PauseButton/Label") as Label
@onready var continue_icon := get_node("ControlTopCenter/PauseButton/ContinueIcon") as TextureRect

var time := 0.0

func _process(delta):
	if world.game_paused: return
		
	_update_timer(delta)
	count_label.text = str(world.coins_collected)	


func _update_timer(delta):
	time += delta
	var seconds = fmod(time, 60)
	var minutes = fmod(time, 3600) / 60

	var minutes_formatted = "%02d" % minutes
	var seconds_formatted = "%02d" % seconds

	timer_label.text = minutes_formatted + ":" + seconds_formatted


func _on_pause_button_toggled(toggled_on:bool):
	world.game_paused = toggled_on
	get_tree().paused = toggled_on
	pause_label.visible = !toggled_on
	continue_icon.visible = toggled_on

	if toggled_on: 
		world.movement_disabled = true
	else:
		world.movement_disabled = false

