class_name World extends Node3D

@onready var coin_collect_audio := get_node("Audio/CoinCollectAudio") as AudioStreamPlayer
@onready var background_audio := get_node("Audio/BackgroundAudio") as AudioStreamPlayer

var coin_scene: Resource = preload("res://objects/coin/coin.tscn")
var coins_collected = 0


func _ready():
	background_audio.play()


func _process(_delta):
	pass
	

func handle_enemy_death(enemy_pos: Vector3):
	var coin = coin_scene.instantiate()
	coin.position = enemy_pos
	coin.position.y = 0.5
	add_child(coin)


func play_coin_collect_audio():
	coin_collect_audio.play()


func _on_main_button_pressed():
	get_tree().change_scene_to_file("res://title_screen/title_world.tscn")
