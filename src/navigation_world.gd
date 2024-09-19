class_name NavigationWorld extends Node3D

@onready var nav_character_res := preload("res://navigation_character.tscn") as Resource
@onready var nav_character := get_node("NavigationCharacter") as CharacterBody3D
@onready var nav_target_agent := get_node("NavTarget/NavigationAgent3D") as NavigationAgent3D
@onready var position_marker := get_node("PositionMarker") as MeshInstance3D


func _ready():
	pass
	# get_tree().create_timer(1).timeout.connect(spawn_nav_agent)
	# spawn_nav_agent(Vector3(0, 0, 0))

func _unhandled_input(_event: InputEvent):
	if Input.is_action_just_pressed("LeftClick"):
		nav_target_agent.target_position = nav_character.position
		print("reachable: ", nav_target_agent.is_target_reachable())
		print("final_position", nav_target_agent.get_final_position())
		position_marker.position = nav_target_agent.get_final_position()

func spawn_nav_agent(pos: Vector3):
	var nav_agent = load("res://navigation_character.tscn").instantiate() as NavigationAgent3D
	nav_agent.position = pos
	add_child(nav_agent)
