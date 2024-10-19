class_name World extends Node3D

@onready var coin_collect_audio := get_node("Audio/CoinCollectAudio") as AudioStreamPlayer
@onready var background_audio := get_node("Audio/BackgroundAudio") as AudioStreamPlayer
@onready var player := get_node("Player") as BaseCharacter
@onready var stick := get_node("UI/Stick") as Stick
@onready var game_ui := get_node("UI") as GameUI

static var coin_scene := preload("res://objects/coin/coin.tscn")
enum GAMESTATE {PLAYING, PAUSED, ENDED}

var state = GAMESTATE.PLAYING
var coins_collected := 0
var enemy_count := 1

func _ready():
	background_audio.play()

func _unhandled_input(_event):
	var viewport = get_viewport()
	var visible_rect := viewport.get_visible_rect()
	var mouse_position := viewport.get_mouse_position()

	if Input.is_action_just_pressed("LeftClick"):
		game_ui.handle_left_mouse_click()
		if state == GAMESTATE.PLAYING:
			if mouse_position.y > visible_rect.size.y * 0.6:
				player.handle_left_mouse_pressed()
				stick.handle_left_mouse_pressed()
			
	if Input.is_action_just_released("LeftClick"):
		game_ui.handle_left_mouse_release()
		if state == GAMESTATE.PLAYING:
			player.handle_left_mouse_released()
			stick.handle_left_mouse_released()

func handle_player_death():
	state = GAMESTATE.ENDED
	game_ui.handle_game_end()

func handle_enemy_death(enemy_pos: Vector3):
	var coin = coin_scene.instantiate()
	coin.position = enemy_pos
	coin.position.y = 1.25
	add_child(coin)

func play_coin_collect_audio():
	coin_collect_audio.play()

func _on_main_button_pressed():
	get_tree().change_scene_to_file("res://title_screen/title_world.tscn")


