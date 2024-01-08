extends Node2D

var control: Control
var play_button: Button
var tutorial_button: Button


func _ready():
	control = get_node("Control") as Control
	play_button = control.get_node("PlayButton")




func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://world/development_world.tscn")
