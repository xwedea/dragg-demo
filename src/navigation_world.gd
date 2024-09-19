extends Node3D

@onready var nav_character := preload("res://navigation_character.tscn")

func _ready():
	pass
	# get_tree().create_timer(1).timeout.connect(spawn_nav_agent)
	# spawn_nav_agent(Vector3(0, 0, 0))



func spawn_nav_agent(pos: Vector3):
	var nav_agent = load("res://navigation_character.tscn").instantiate()
	nav_agent.position = pos
	add_child(nav_agent)
