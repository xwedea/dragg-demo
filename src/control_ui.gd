extends Control

@export var max_distance: float = 47

var stick_circle_container: Control
var stick_button_container: Control
var is_screen_pressed: bool = false
var game_viewport: Viewport

func _ready():
	game_viewport = get_viewport()
	stick_circle_container = get_node("StickCircleContainer") as Control
	stick_button_container = get_node("StickButtonContainer") as Control

	stick_circle_container.visible = false
	stick_button_container.visible = false

func _process(_delta: float) -> void:
	var mousePosition: Vector2 = game_viewport.get_mouse_position()

	if is_screen_pressed:
		stick_button_container.position = mousePosition
		if stick_circle_container.position.distance_to(mousePosition) > max_distance:
			var direction = (mousePosition - stick_circle_container.position).normalized()
			stick_button_container.position = stick_circle_container.position + direction * max_distance

	if Input.is_action_just_pressed("LeftClick"):
		is_screen_pressed = true
		stick_button_container.position = mousePosition
		stick_circle_container.position = mousePosition

		stick_button_container.visible = true
		stick_circle_container.visible = true
	elif Input.is_action_just_released("LeftClick"):
		stick_button_container.visible = false
		stick_circle_container.visible = false
