class_name TitleEnemy extends CharacterBody3D

# @onready var world := get_tree().root.get_node("World3D") as Node3D
@onready var death_timer := get_node("DeathTimer") as Timer
@onready var knock_out_timer := get_node("KnockOutTimer") as Timer
# @onready var player= get_node("TitleCharacter") as TitleCharacter
@onready var model := get_node("Model") as Node3D
@onready var anim_player := model.get_node("AnimationPlayer") as AnimationPlayer
@onready var collision_shape := get_node("CapsuleCollision") as CollisionShape3D
@onready var hit_audio := get_node("HitAudio") as AudioStreamPlayer

@export var death_threshold := 30
@export var speed := 100


func _ready():
	randomize()
	# var anim_delay = randf_range(0, 1)
	# await get_tree().create_timer(anim_delay).timeout
	# anim_player.play("Run")
	anim_player.play("Idle")


func _physics_process(_delta: float) -> void:
	pass
	# look_at(player.global_position)

func _on_HitBox_body_entered(_body: Node3D) -> void:
	pass

func _on_hit_box_body_exited(_body):
	pass

	
