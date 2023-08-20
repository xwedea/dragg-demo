class_name Ball extends RigidBody3D

@export var MaxKickDistance: float = 8
@export var LineLength: float = 5
@export var PullForce: float = 10
@export var RopeThickness: float = 0.1
@export var RopeColor: Color
@export var OverrideRopeColor: bool = false

var World: Node3D
var Player: BaseCharacter
var PreviousRope: MeshInstance3D

func _ready():
	World = get_tree().root.get_node("World3D") as Node3D
	Player = World.get_node("BaseCharacter") as BaseCharacter
	
	if not OverrideRopeColor:
		RopeColor = Color(1, 0, 0) # Red
	PreviousRope = create_line_mesh(global_position, Player.global_position, RopeThickness, RopeColor)

func _physics_process(delta: float) -> void:
	draw_rope()

func draw_rope() -> void:
	if not OverrideRopeColor:
		var distance = global_position.distance_to(Player.global_position)
		if distance < MaxKickDistance / 2:
			RopeColor = Color(1, 0, 0) # Red
		elif distance < MaxKickDistance / 1.3:
			RopeColor = Color(1, 0.27, 0.0) # OrangeRed
		elif distance < MaxKickDistance:
			RopeColor = Color(1, 0.5, 0.0) # Orange
		else:
			RopeColor = Color(1, 1, 1) # White
	
	var line = create_line_mesh(global_position, Player.global_position, RopeThickness, RopeColor)
	World.add_child(line)
	PreviousRope.queue_free()
	
	PreviousRope = line
	

func create_line_mesh(ballPos: Vector3, playerPos: Vector3, thickness: float, color: Color) -> MeshInstance3D:
	var meshInstance: MeshInstance3D = MeshInstance3D.new()
	meshInstance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	var arrayMesh: ArrayMesh = ArrayMesh.new()
	meshInstance.mesh = arrayMesh
	
	var ballPos_right: Vector3 = ballPos + ballPos.direction_to(playerPos).cross(Vector3.UP).normalized() * thickness
	var ballPos_left: Vector3 = ballPos + ballPos.direction_to(playerPos).cross(Vector3.DOWN).normalized() * thickness
	var playerPos_left: Vector3 = playerPos + playerPos.direction_to(ballPos).cross(Vector3.UP).normalized() * thickness
	var playerPos_right: Vector3 = playerPos + playerPos.direction_to(ballPos).cross(Vector3.DOWN).normalized() * thickness

	var meshData: Array = []
	meshData.resize(int(ArrayMesh.ARRAY_MAX))
	var verts : PackedVector3Array = [
		ballPos_left, ballPos, playerPos_left, 
		playerPos_left, ballPos, playerPos,
		playerPos, ballPos, ballPos_right,
		ballPos_right, playerPos_right, playerPos
	]
	meshData[int(Mesh.ARRAY_VERTEX)] = verts
	arrayMesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, meshData)

	return meshInstance

