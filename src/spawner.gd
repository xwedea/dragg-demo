extends Node

@export var spawn_distance : float = 15

@onready var world := get_tree().root.get_node("World3D") as Node3D
@onready var player := world.get_node("Player") as BaseCharacter
@onready var spawn_timer := get_node("SpawnTimer") as Timer

static var enemy_scene := preload("res://enemy/base_enemy.tscn")

func _ready():
	spawn_timer.start()

func spawn_enemy() -> BaseEnemy:
	var visible_rect_size = get_viewport().get_visible_rect().size	
	var player_position_leveled = player.global_position
	player_position_leveled.y = 1

	# var spawn_side = 1 if randi() % 2 == 0 else -1 # left (-1) or right (1)
	var spawn_side = 1
	var spawn_position = player_position_leveled + Vector3(spawn_side * visible_rect_size.x / 50, 0, 0)

	var new_enemy = enemy_scene.instantiate() as BaseEnemy
	new_enemy.visible = false
	new_enemy.position = spawn_position
	world.get_node("Enemies").add_child(new_enemy)

	new_enemy.nav_agent.target_position = player_position_leveled
	if not new_enemy.nav_agent.is_target_reachable():
		spawn_position = player_position_leveled + Vector3(-spawn_side * visible_rect_size.x / 50, 0, 0)
		new_enemy.position = spawn_position
		# print("unreachable")
		# print("new spawn location: ", new_enemy.global_position)
		# print("new location reachable: ", new_enemy.nav_agent.is_target_reachable())

	else:
		pass
		# print("reachable")
	
	new_enemy.visible = true
	return new_enemy
	

func _on_spawn_timer_timeout():
	spawn_enemy()
	spawn_timer.start()