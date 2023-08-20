extends Camera3D

var world: Node3D
var player: BaseCharacter
var character_camera_controller: Node3D

func _ready():
	world = get_tree().root.get_node("World3D") as Node3D
	player = world.get_node("BaseCharacter") as BaseCharacter
	character_camera_controller = player.get_node("CameraController") as Node3D

func _physics_process(_delta: float) -> void:
	var newPosition: Vector3 = position.lerp(character_camera_controller.global_position, 0.1)
	position = newPosition
