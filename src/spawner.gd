extends Node

@export var spawn_range : float = 15

var player : BaseCharacter
var world : Node3D
var spawn_timer : Timer

var enemy_scene = load("res://enemy/base_enemy.tscn")

func _ready():
	world = get_tree().root.get_node("World3D") as Node3D
	player = world.get_node("Player") as BaseCharacter
	spawn_timer = get_node("SpawnTimer") as Timer
	spawn_timer.start()


func spawn_enemy() -> BaseEnemy:
	var random_x = randf_range(-1, 1)
	var random_z = randf_range(-1, 1)
	var random_direction = Vector3(random_x, 0, random_z).normalized()
	var spawn_position = player.position + random_direction * spawn_range

	var new_enemy = enemy_scene.instantiate()
	new_enemy.position = spawn_position
	world.get_node("Enemies").add_child(new_enemy)
	return new_enemy
	
func _on_spawn_timer_timeout():
	spawn_enemy()
	spawn_timer.start()
