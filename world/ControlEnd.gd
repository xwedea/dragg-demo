extends Control

@onready var color_rect := get_node("ColorRect") as ColorRect
@onready var go_button := get_node("GoButton") as ButtonControl

func _ready():
	visible = false
	color_rect.visible = false
	go_button.visible = false	


func _on_go_button_pressed():
	get_tree().change_scene_to_file("res://world/development_world.tscn")
