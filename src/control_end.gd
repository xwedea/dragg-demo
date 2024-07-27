extends Control

@onready var color_rect := get_node("ColorRect") as ColorRect
@onready var again_button := get_node("AgainButton") as ButtonControl

func _ready():
	visible = false
	color_rect.visible = false
	again_button.visible = false	

func _on_again_button_pressed():
	get_tree().change_scene_to_file("res://world/development_world.tscn")

