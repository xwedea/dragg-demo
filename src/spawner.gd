extends Node

@onready var world := get_tree().root.get_node("World3D") as World
@onready var player := world.get_node("Player") as BaseCharacter

@export var wait_time := 2
@export var enemy_limit := 20

static var enemy_scene := preload("res://enemy/base_enemy.tscn")
var timer : Timer

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_spawn_timer_timeout)
	timer.wait_time = wait_time
	timer.start()

func spawn_enemy() -> BaseEnemy:
	var player_position_leveled = player.global_position
	player_position_leveled.y = 1

	var spawn_side = 1 if randi() % 2 == 0 else -1 # left (-1) or right (1)
	# var visible_rect_size = get_viewport().get_visible_rect().size
	# var spawn_offset_x = spawn_side * visible_rect_size.x / 50
	var spawn_offset_x = spawn_side * 10
	var random_z = randi_range(-50, 50)
	var spawn_position = player_position_leveled + Vector3(spawn_offset_x, 0, random_z)

	# check if spawn position is valid
	player.nav_agent.target_position = spawn_position
	if not player.nav_agent.is_target_reachable():
		spawn_position = player.nav_agent.get_final_position()
		spawn_position.y = 1

	var new_enemy = enemy_scene.instantiate() as BaseEnemy
	new_enemy.position = spawn_position
	world.get_node("Enemies").add_child(new_enemy)

	world.enemy_count += 1
	print(world.enemy_count)
	return new_enemy

func _on_spawn_timer_timeout():
	if world.state == world.GAMESTATE.PLAYING and world.enemy_count < enemy_limit:
		spawn_enemy()
	timer.start()