class_name World extends Node3D

@onready var coin_collect_audio := get_node("Audio/CoinCollectAudio") as AudioStreamPlayer
@onready var background_audio := get_node("Audio/BackgroundAudio") as AudioStreamPlayer
@onready var player := get_node("Player") as BaseCharacter
@onready var control_sticks := get_node("UI/ControlSticks") as ControlSticks


enum GAMESTATE {PLAYING, COUNTDOWN, PAUSED}
var state = GAMESTATE.PLAYING

var coin_scene: Resource = preload("res://objects/coin/coin.tscn")
var coins_collected = 0

func _ready():
	background_audio.play()


func _unhandled_input(_event):
	if Input.is_action_just_pressed("LeftClick"):
		player.handle_left_mouse_click()
		control_sticks.handle_left_mouse_click()
	if Input.is_action_just_released("LeftClick"):
		player.handle_left_mouse_release()
		control_sticks.handle_left_mouse_release()


func handle_enemy_death(enemy_pos: Vector3):
	var coin = coin_scene.instantiate()
	coin.position = enemy_pos
	coin.position.y = 1.25
	add_child(coin)


func play_coin_collect_audio():
	coin_collect_audio.play()


func _on_main_button_pressed():
	get_tree().change_scene_to_file("res://title_screen/title_world.tscn")


