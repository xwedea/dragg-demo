extends Control

@onready var color_overlay := get_parent().get_node("Overlay") as ColorRect
@onready var again_button := get_node("AgainButton") as ButtonControl

func _ready():
	visible = false
	color_overlay.visible = false
	again_button.visible = false

	color_overlay.size = get_viewport_rect().size + Vector2(200, 200)
	get_viewport().size_changed.connect(_on_viewport_size_changed)

func _on_again_button_pressed():
	get_tree().change_scene_to_file("res://world/development_world.tscn")

func _on_viewport_size_changed():
	color_overlay.size = get_viewport_rect().size + Vector2(200, 200)
	
func _resize_overlay():
	pass


