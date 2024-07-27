class_name Ball extends RigidBody3D

@onready var world := get_tree().root.get_node("World3D") as World
@onready var player := world.get_node("Player") as BaseCharacter
@onready var kick_timer := get_node("KickTimer") as Timer
@onready var arrow := get_node("Arrow") as Node3D

@export var max_kick_distance := 3
@export var hit_force := 2
@export var line_length := 5
@export var pull_force := 3
@export var rope_thickness := 0.1
@export var rope_color: Color
@export var override_rope_color := false
@export var arrow_distance := 0.75

var is_just_kicked := false
var player_in_active_area := false
var distance_to_player : float
var player_to_ball : Vector3

func _ready():
	if !override_rope_color:
		rope_color = Color(1, 0, 0) # Red

func _physics_process(_delta: float) -> void:
	distance_to_player =  position.distance_to(player.position)
	player_to_ball = player.position.direction_to(position)
	player_to_ball.y = 0

	arrow.visible = distance_to_player <= max_kick_distance
	arrow.position = position + player_to_ball * arrow_distance
	arrow.look_at(arrow.position + player_to_ball)
	arrow.scale.z = 1/distance_to_player


func kick():
	is_just_kicked = true
	kick_timer.start()

	player_to_ball.y = 0;
	var force = player.kick_force - 10 * distance_to_player;
	var ballImpulse = force * player_to_ball;
	apply_impulse(ballImpulse);

func _on_kick_timer_timeout():
	is_just_kicked = false

func _on_active_area_body_entered(_body:Node3D):
	player_in_active_area = true

func _on_active_area_body_exited(_body:Node3D):
	player_in_active_area = false


# func _draw_rope() -> void:
# 	if !override_rope_color:
# 		var distance = global_position.distance_to(player.global_position)
# 		if distance < max_kick_distance / 2:
# 			rope_color = Color(1, 0, 0) # Red
# 		elif distance < max_kick_distance / 1.3:
# 			rope_color = Color(1, 0.27, 0.0) # OrangeRed
# 		elif distance < max_kick_distance:
# 			rope_color = Color(1, 0.5, 0.0) # Orange
# 		else:
# 			rope_color = Color(1, 1, 1) # White

# 	var previous_rope = MeshInstance3D.new()
# 	var line = _create_line_mesh(global_position, player.rope_slot.global_position, rope_thickness, rope_color)
	
# 	world.add_child(line)
# 	previous_rope.queue_free()

# 	previous_rope = line


# func _create_line_mesh(ballPos: Vector3, playerPos: Vector3, thickness: float, _color: Color) -> MeshInstance3D:
# 	var mesh_instance: MeshInstance3D = MeshInstance3D.new()
# 	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

# 	var array_mesh: ArrayMesh = ArrayMesh.new()
# 	mesh_instance.mesh = array_mesh
	
# 	var mesh_data: Array = []
# 	mesh_data.resize(ArrayMesh.ARRAY_MAX)
# 	var ballPos_left: Vector3 = ballPos + ballPos.direction_to(playerPos).cross(Vector3.UP).normalized() * thickness
# 	var ballPos_right: Vector3 = ballPos + ballPos.direction_to(playerPos).cross(Vector3.DOWN).normalized() * thickness
# 	var playerPos_right: Vector3 = playerPos + playerPos.direction_to(ballPos).cross(Vector3.UP).normalized() * thickness
# 	var playerPos_left: Vector3 = playerPos + playerPos.direction_to(ballPos).cross(Vector3.DOWN).normalized() * thickness
# 	var verts = PackedVector3Array([
# 				ballPos_left, ballPos, playerPos_left, 
# 				playerPos_left, ballPos, playerPos,
# 				playerPos, ballPos, ballPos_right,
# 				ballPos_right, playerPos_right, playerPos
# 			])
# 	mesh_data[Mesh.ARRAY_VERTEX] = verts
# 	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, mesh_data)

# 	return mesh_instance
