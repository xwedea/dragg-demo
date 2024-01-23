extends Camera3D

@onready var world := get_tree().root.get_node("World3D") as Node3D
@onready var player := world.get_node("Player") as BaseCharacter
@onready var character_camera_controller := player.get_node("CameraController") as Node3D


func _physics_process(_delta: float) -> void:
	var newPosition: Vector3 = position.lerp(character_camera_controller.global_position, 0.1)
	position = newPosition
