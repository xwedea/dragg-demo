extends Control

@onready var play_button := get_node("PlayButton")


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://world/development_world.tscn")



func _on_texture_button_pressed():
	pass # Replace with function body.
