class_name TitleCharacter extends CharacterBody3D

@onready var anim_player := get_node("Model/AnimationPlayer") as AnimationPlayer 
@onready var turn_timer := get_node("TurnTimer") as Timer
@onready var collision_shape := get_node("CapsuleCollision") as CollisionShape3D

@export var speed_multiplier = 2

func _ready():
	randomize()
	anim_player.play("Idle")

