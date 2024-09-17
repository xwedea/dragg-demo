class_name TitleCharacter extends CharacterBody3D

@onready var anim_player := get_node("Model/AnimationPlayer") as AnimationPlayer 
@onready var turn_timer := get_node("TurnTimer") as Timer
@onready var collision_shape := get_node("CapsuleCollision") as CollisionShape3D

@export var speed_multiplier = 2

var opposite := false

func _ready():
	randomize()
	var anim_delay = randf_range(0, 0.2)
	# await get_tree().create_timer(anim_delay).timeout
	anim_player.play("Idle")
	# anim_player.play("Run")

