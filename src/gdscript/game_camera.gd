extends Camera3D

var World: Node3D
var Character: Node3D
var CharacterCameraController: Node3D

func _ready():
	World = get_tree().root.get_node("World3D") as Node3D
	Character = World.get_node("BaseCharacter") as Node3D
	CharacterCameraController = Character.get_node("CameraController") as Node3D

func _physics_process(delta: float) -> void:
	var newPosition: Vector3 = position.lerp(CharacterCameraController.global_position, 0.1)
	position = newPosition
