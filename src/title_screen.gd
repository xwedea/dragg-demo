extends Node2D

@onready var play_button := get_node("PlayButton")
@onready var tutorial_button := get_node("TutorialButton")
@onready var title_audio := get_node("TitleAudio")


func _ready():
	title_audio.play()


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://world/development_world.tscn")


