extends Control

@export var max_distance: float = 47

var world: World
var stick_circle_container: Control
var stick_button_container: Control
var is_screen_pressed: bool = false
var game_viewport: Viewport

func _ready():
	game_viewport = get_viewport()
	world = get_tree().root.get_node("World3D") as World
	stick_circle_container = get_node("StickCircleContainer") as Control
	stick_button_container = get_node("StickButtonContainer") as Control
	
	visible = false



func _process(_delta: float) -> void:
	var mouse_position: Vector2 = game_viewport.get_mouse_position()

	if is_screen_pressed:
		if position.distance_to(mouse_position) <= max_distance:
			stick_button_container.global_position = mouse_position
		else:
			var direction = (mouse_position - position).normalized()
			stick_button_container.global_position = position + direction * max_distance

	if Input.is_action_just_pressed("LeftClick"):
		is_screen_pressed = true
		position = mouse_position
		visible = true
	elif Input.is_action_just_released("LeftClick"):
		visible = false
	
