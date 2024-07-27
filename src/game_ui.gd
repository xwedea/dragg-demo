class_name UserInterfaceNode extends Node

@onready var world := get_tree().root.get_node("World3D") as World
@onready var player := world.get_node("Player") as BaseCharacter
@onready var control_sticks := get_node("ControlSticks") as ControlSticks
@onready var minutes_label := get_node("ControlTopCenter/ControlTimer/Minutes") as Label
@onready var seconds_label := get_node("ControlTopCenter/ControlTimer/Seconds") as Label
@onready var count_label := get_node("ControlTopCenter/ControlCoin/CoinLabel") as Label
@onready var pause_label := get_node("ControlTopCenter/PauseButton/Label") as Label
@onready var continue_icon := get_node("ControlTopCenter/PauseButton/ContinueIcon") as TextureRect
@onready var pause_menu := get_node("ControlCenter/ControlPauseMenu") as Control
@onready var title_world := load("res://title/title_world.tscn") as PackedScene
@onready var end_control := get_node("ControlEnd") as Control
@onready var end_overlay := end_control.get_node("ColorRect") as ColorRect
@onready var end_anim_player := end_control.get_node("AnimationPlayer") as AnimationPlayer

var time := 0.0

func _ready():
	pause_menu.visible = false


func _process(delta):
	if world.state != world.GAMESTATE.PLAYING: return
		
	_update_timer(delta)
	count_label.text = str(world.coins_collected)	


func _update_timer(delta):
	time += delta
	var seconds = fmod(time, 60)
	var minutes = fmod(time, 3600) / 60

	minutes_label.text = "%02d" % minutes
	seconds_label.text = "%02d" % seconds

func handle_game_end():
	control_sticks.visible = false
	end_anim_player.play("appear")

func _on_pause_button_toggled(toggled_on:bool):
	get_tree().paused = toggled_on
	pause_label.visible = !toggled_on
	continue_icon.visible = toggled_on
	pause_menu.visible = toggled_on

	if toggled_on:
		world.state = world.GAMESTATE.PAUSED
	else:
		world.state = world.GAMESTATE.PLAYING


func _on_end_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(title_world)
	
