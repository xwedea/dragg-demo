extends Node

@onready var play_button := get_node("PlayButton") as ButtonControl

func _ready():
	play_button.texture_button.pressed.connect(_on_play_button_pressed)

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://world/game_world.tscn")

