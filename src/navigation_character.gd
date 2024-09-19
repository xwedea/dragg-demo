extends CharacterBody3D

@onready var nav_world := get_tree().root.get_node("NavigationWorld") as NavigationWorld
@onready var nav_target := nav_world.get_node("NavTarget") as Node3D
@onready var nav_agent := get_node("NavigationAgent3D") as NavigationAgent3D

@export var speed := 1000

func _ready():
	# print(name + " is ready at: " + str(position))
	pass

func _process(delta):
	if nav_agent.is_target_reached():
		return

	var target_position = nav_target.global_position
	target_position.y = 0
	nav_agent.target_position = target_position
	var nextPathPosition = nav_agent.get_next_path_position()

	# print("***")
	# print("my location: ", global_position)
	# print("target_location: ", target_position)
	# print("is target reachable: ", nav_agent.is_target_reachable())
	# print("final position: ", nav_agent.get_final_position())
	# nav_world.position_marker.position = nav_agent.get_final_position()
	# print("next path position: ", nextPathPosition)
	
	var direction = nextPathPosition - global_position
	direction.y = 0
	
	velocity = direction.normalized() * speed * delta
	# nav_agent.velocity = direction.normalized() * speed * delta
	# print("velocity: ", velocity)

	# var collided := move_and_slide()
	# print("collided: ", collided)
