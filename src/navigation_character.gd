extends CharacterBody3D

@onready var nav_world := get_tree().root.get_node("NavigationWorld")
@onready var nav_target := nav_world.get_node("NavTarget")
@onready var nav_agent := get_node("NavigationAgent3D")

@export var speed := 1000

func _ready():
	print("following " + nav_target.name)
	pass

func _process(delta):
	nav_agent.target_position = nav_target.global_position
	var nextPathPosition: Vector3 = nav_agent.get_next_path_position()
	var direction: Vector3 = nextPathPosition - global_position
	velocity = direction.normalized() * speed * delta
	
	move_and_slide()