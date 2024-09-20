class_name UserInterfaceNode extends Node

@onready var world := get_tree().root.get_node("World3D") as World
@onready var player := world.get_node("Player") as BaseCharacter
@onready var control_top_center := get_node("Score") as Control
@onready var end_button := get_node("PauseMenu/EndButton") as ButtonControl
@onready var control_sticks := get_node("Sticks") as ControlSticks
@onready var minutes_label := get_node("Score/ControlTimer/Minutes") as Label
@onready var seconds_label := get_node("Score/ControlTimer/Seconds") as Label
@onready var count_label := get_node("Score/ControlCoin/CoinLabel") as Label
@onready var pause_label := get_node("PauseButton/Label") as Label
@onready var continue_icon := get_node("PauseButton/ContinueIcon") as TextureRect
@onready var pause_menu := get_node("PauseMenu") as Control
@onready var title_world := load("res://title/title_world.tscn") as PackedScene
@onready var end_control := get_node("Ending") as Control
@onready var end_overlay := get_node("Overlay") as ColorRect
@onready var end_anim_player := end_control.get_node("AnimationPlayer") as AnimationPlayer
@onready var end_label := end_control.get_node("Label") as Label
@onready var pause_button := get_node("PauseButton") as ButtonControl

var time := 0.0

func _ready():
	pause_menu.visible = false

func _process(delta):
	if not world.state == world.GAMESTATE.PLAYING: return
		
	_update_timer(delta)
	count_label.text = str(world.coins_collected)	

func _update_timer(delta):
	time += delta
	var seconds = fmod(time, 60)
	var minutes = fmod(time, 3600) / 60

	minutes_label.text = "%02d" % minutes
	seconds_label.text = "%02d" % seconds

func handle_game_end():
	pause_button.visible = false
	control_sticks.visible = false
	control_top_center.visible = false
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
	player.ball.arrow.visible = false 
	player.health = 0
	player.health_bar.value = 0
	end_label.text = "YOU ENDED"
	player.health = 0
	end_button.visible = false
	get_tree().paused = false
	player.die()	
