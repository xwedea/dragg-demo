extends Control

@onready var color_overlay := get_parent().get_node("Overlay") as ColorRect
@onready var again_button_controller := get_node("AgainButton") as ButtonControl
@onready var home_button_controller := get_node("HomeButton") as ButtonControl

func _ready():
	visible = false
	color_overlay.visible = false
	again_button_controller.visible = false
	home_button_controller.visible = false

	color_overlay.size = get_viewport_rect().size + Vector2(200, 200)

	get_viewport().size_changed.connect(_on_viewport_size_changed)
	home_button_controller.texture_button.pressed.connect(_on_home_button_pressed)

func _on_again_button_pressed():
	get_tree().change_scene_to_file("res://world/development_world.tscn")

func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://title/title_world.tscn")

func _on_viewport_size_changed():
	color_overlay.size = get_viewport_rect().size + Vector2(200, 200)
	
func _resize_overlay():
	pass


