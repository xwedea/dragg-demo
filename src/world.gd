class_name World extends Node3D

var coin_scene: Resource = preload("res://objects/coin/coin.tscn")
var coin_collect_audio: AudioStreamPlayer


func _ready():
	coin_collect_audio = get_node("Audio/CoinCollectAudio")


func handle_enemy_death(enemy_pos: Vector3):
	var coin = coin_scene.instantiate()
	coin.position = enemy_pos
	coin.position.y = 0.5
	add_child(coin)


func play_coin_collect_audio():
	coin_collect_audio.play()
