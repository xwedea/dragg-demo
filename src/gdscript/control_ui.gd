extends Control

@export var maxDistance: float = 35

var StickCircleContainer: Control
var StickButtonContainer: Control
var isScreenPressed: bool = false
var GameViewport: Viewport

func _ready():
	GameViewport = get_viewport()
	StickCircleContainer = get_node("StickCircleContainer") as Control
	StickButtonContainer = get_node("StickButtonContainer") as Control

	StickCircleContainer.visible = false
	StickButtonContainer.visible = false

func _process(delta: float) -> void:
	var mousePosition: Vector2 = GameViewport.get_mouse_position()

	if isScreenPressed:
		StickButtonContainer.position = mousePosition

		if StickCircleContainer.position.distance_to(mousePosition) > maxDistance:
			var direction: Vector2 = (mousePosition - StickCircleContainer.position).normalized()
			StickButtonContainer.position = StickCircleContainer.position + direction * maxDistance

	if Input.is_action_just_pressed("LeftClick"):
		isScreenPressed = true
		StickButtonContainer.position = mousePosition
		StickCircleContainer.position = mousePosition

		StickButtonContainer.visible = true
		StickCircleContainer.visible = true
	elif Input.is_action_just_released("LeftClick"):
		StickButtonContainer.visible = false
		StickCircleContainer.visible = false
