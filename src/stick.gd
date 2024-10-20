class_name Stick extends Control

@onready var world := get_tree().root.get_node("World3D") as World
@onready var stick_circle := get_node("StickCircle") as Control
@onready var stick_button := get_node("StickButton") as Control
@onready var game_viewport := get_viewport()

@export var max_distance: float = 47

var mouse_position: Vector2
var screen_is_pressed := false

func _ready():
	visible = false

func _process(_delta: float) -> void:
	if world.state != world.GAMESTATE.PLAYING: return

	mouse_position = game_viewport.get_mouse_position()

	if screen_is_pressed:
		if position.distance_to(mouse_position) <= max_distance:
			stick_button.global_position = mouse_position
		else:
			var direction = (mouse_position - position).normalized()
			stick_button.global_position = position + direction * max_distance

func handle_left_mouse_pressed():
	position = game_viewport.get_mouse_position()
	screen_is_pressed = true
	visible = true

func handle_left_mouse_released():
	screen_is_pressed = false
	visible = false
