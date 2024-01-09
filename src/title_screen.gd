extends Node2D

var play_button: TextureButton
var tutorial_button: TextureButton
var title_audio: AudioStreamPlayer

func _ready():
	play_button = get_node("PlayButton")
	title_audio = get_node("TitleAudio")
	title_audio.play()


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://world/development_world.tscn")


