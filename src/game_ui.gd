class_name GameUI extends Node

@onready var world := get_tree().root.get_node("World3D") as World
@onready var player := world.get_node("Player") as BaseCharacter
@onready var control_top_center := get_node("Score") as Control
@onready var end_button_control := get_node("PauseMenu/EndButton") as ButtonControl
@onready var control_stick := get_node("Stick") as Stick
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
@onready var pause_button_control := get_node("PauseButton") as ButtonControl
@onready var shadow_stick := get_node("ShadowStick") as Control

var screen_pressed := false

func _ready():
	var visible_rect := get_viewport().get_visible_rect()
	pause_menu.visible = false
	shadow_stick.visible = true
	shadow_stick.position = Vector2(visible_rect.size.x * 0.5, visible_rect.size.y * 0.75)

	pause_button_control.texture_button.toggled.connect(_on_pause_button_toggled)
	end_button_control.texture_button.pressed.connect(_on_end_button_pressed)

func _process(delta):
	if not world.state == world.GAMESTATE.PLAYING: return
	
	_update_timer()
	count_label.text = str(world.coins_collected)	

func _update_timer():
	var seconds = fmod(world.time, 60)
	var minutes = fmod(world.time, 3600) / 60

	minutes_label.text = "%02d" % minutes
	seconds_label.text = "%02d" % seconds

func handle_game_end():
	pause_button_control.visible = false
	control_stick.visible = false
	control_top_center.visible = false
	end_anim_player.play("appear")

func _on_pause_button_toggled(toggled_on:bool):
	get_tree().paused = toggled_on
	pause_label.visible = !toggled_on
	continue_icon.visible = toggled_on
	pause_menu.visible = toggled_on
	shadow_stick.visible = false

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
	end_button_control.visible = false
	get_tree().paused = false
	player.die()

func handle_left_mouse_click():
	screen_pressed = true
	shadow_stick.visible = false

func handle_left_mouse_release():
	screen_pressed = false
	# shadow_stick.visible = true