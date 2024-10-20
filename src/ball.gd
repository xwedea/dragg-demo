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

@export var arrow_distance := 0.75

var is_just_kicked := false
var player_is_in_active_area := false
var distance_to_player : float
var player_to_ball : Vector3

func _ready():
	pass

func _physics_process(_delta: float) -> void:
	if world.state != world.GAMESTATE.PLAYING: return

	distance_to_player = position.distance_to(player.position)
	player_to_ball = player.position.direction_to(position)
	player_to_ball.y = 0

	arrow.visible = distance_to_player <= max_kick_distance
	arrow.position = position + player_to_ball * arrow_distance
	arrow.look_at(arrow.position + player_to_ball)
	arrow.scale.z = 1/distance_to_player

func kick():
	if world.state != world.GAMESTATE.PLAYING: return

	is_just_kicked = true
	kick_timer.start()

	player_to_ball.y = 0;
	var force = player.kick_force - 10 * distance_to_player;
	var ballImpulse = force * player_to_ball;
	apply_impulse(ballImpulse);

func _on_kick_timer_timeout():
	is_just_kicked = false

func _on_active_area_body_entered(_body:Node3D):
	player_is_in_active_area = true

func _on_active_area_body_exited(_body:Node3D):
	player_is_in_active_area = false

