class_name Ball extends RigidBody3D

@export var max_kick_distance: float = 8
@export var line_length: float = 5
@export var pull_force: float = 10
@export var rope_thickness: float = 0.1
@export var rope_color: Color
@export var override_rope_color: bool = false

var world: Node3D
var player: BaseCharacter
var previous_rope: MeshInstance3D

func _ready():
	world = get_tree().root.get_node("World3D") as Node3D
	player = world.get_node("BaseCharacter") as BaseCharacter
	
	if !override_rope_color:
		rope_color = Color(1, 0, 0) # Red
	previous_rope = _create_line_mesh(global_position, player.rope_slot.global_position, rope_thickness, rope_color)

func _physics_process(_delta: float) -> void:
	_draw_rope()

func _draw_rope() -> void:
	if !override_rope_color:
		var distance = global_position.distance_to(player.global_position)
		if distance < max_kick_distance / 2:
			rope_color = Color(1, 0, 0) # Red
		elif distance < max_kick_distance / 1.3:
			rope_color = Color(1, 0.27, 0.0) # OrangeRed
		elif distance < max_kick_distance:
			rope_color = Color(1, 0.5, 0.0) # Orange
		else:
			rope_color = Color(1, 1, 1) # White
	
	var line = _create_line_mesh(global_position, player.rope_slot.global_position, rope_thickness, rope_color)
	world.add_child(line)
	previous_rope.queue_free()
	
	previous_rope = line
	

func _create_line_mesh(ballPos: Vector3, playerPos: Vector3, thickness: float, _color: Color) -> MeshInstance3D:
	var mesh_instance: MeshInstance3D = MeshInstance3D.new()
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	var array_mesh: ArrayMesh = ArrayMesh.new()
	mesh_instance.mesh = array_mesh
	
	var ballPos_left: Vector3 = ballPos + ballPos.direction_to(playerPos).cross(Vector3.UP).normalized() * thickness
	var ballPos_right: Vector3 = ballPos + ballPos.direction_to(playerPos).cross(Vector3.DOWN).normalized() * thickness
	var playerPos_right: Vector3 = playerPos + playerPos.direction_to(ballPos).cross(Vector3.UP).normalized() * thickness
	var playerPos_left: Vector3 = playerPos + playerPos.direction_to(ballPos).cross(Vector3.DOWN).normalized() * thickness

	var mesh_data: Array = []
	mesh_data.resize(ArrayMesh.ARRAY_MAX)
	var verts = PackedVector3Array([
				ballPos_left, ballPos, playerPos_left, 
				playerPos_left, ballPos, playerPos,
				playerPos, ballPos, ballPos_right,
				ballPos_right, playerPos_right, playerPos
			])
	mesh_data[Mesh.ARRAY_VERTEX] = verts
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, mesh_data)

	return mesh_instance

