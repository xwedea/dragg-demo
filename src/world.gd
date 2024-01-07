class_name World extends Node3D

var coin_scene: Resource = preload("res://coin.tscn")

func handle_enemy_death(enemy_pos: Vector3):
	print("AAAA")
	var coin = coin_scene.instantiate()
	coin.position = enemy_pos
	# coin.position.y = 1
	add_child(coin)

	print(coin.position)