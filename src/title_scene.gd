class_name TitleScene extends Node3D

@onready var turn_timer := get_node("TurnTimer") as Timer

@export var speed := 3
@export var turn_rate := 5

var is_returning := false
var velocity := Vector3(1, 0, 0)

func _ready():
	turn_timer.wait_time = turn_rate
	# turn_timer.start()

func _process(_delta):
	if is_returning:
		velocity = Vector3(-1, 0, 0)
	else:
		velocity = Vector3(1, 0, 0)
	
	#position = position + (velocity * speed * delta)

func _on_turn_timer_timeout():
	if is_returning:
		rotation = Vector3(0, -90, 0)
		is_returning = false
	else:
		rotation = Vector3(0, 90, 0)
		is_returning = true
	
	turn_timer.start()
