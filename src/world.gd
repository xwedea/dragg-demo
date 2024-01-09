class_name World extends Node3D

var coin_scene: Resource = preload("res://objects/coin/coin.tscn")

var coins_collected = 0

@onready var count_label := $UI/ControlTopLeft/TextureRect/CoinLabel as Label
@onready var coin_collect_audio := $Audio/CoinCollectAudio as AudioStreamPlayer
@onready var background_audio := $Audio/BackgroundAudio as AudioStreamPlayer

func _ready():
	background_audio.play()

func _process(_delta):
	count_label.text = str(coins_collected)

func handle_enemy_death(enemy_pos: Vector3):
	var coin = coin_scene.instantiate()
	coin.position = enemy_pos
	coin.position.y = 0.5
	add_child(coin)


func play_coin_collect_audio():
	coin_collect_audio.play()


func _on_main_button_pressed():
	get_tree().change_scene_to_file("res://title_screen/title_screen.tscn")
