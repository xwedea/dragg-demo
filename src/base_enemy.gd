class_name BaseEnemy extends CharacterBody3D

@onready var world := get_tree().root.get_node("World3D") as World
@onready var ball := world.get_node("Ball") as Ball
@onready var death_timer := get_node("DeathTimer") as Timer
@onready var knock_out_timer := get_node("KnockOutTimer") as Timer
@onready var player := world.get_node("Player") as BaseCharacter
@onready var model := get_node("Model") as Node3D
@onready var anim_player := model.get_node("AnimationPlayer") as AnimationPlayer
@onready var collision_shape := get_node("CapsuleCollision") as CollisionShape3D
@onready var hit_audio := get_node("HitAudio") as AudioStreamPlayer
@onready var hit_box := get_node("HitBox") as Area3D

@export var death_threshold := 30
@export var speed := 100

var gravity := ProjectSettings.get_setting("physics/3d/default_gravity") as float
var is_dead := false
var is_knocked_out := false
var is_colliding_with_ball := false

func _ready():
	anim_player.play("Run")

	hit_box.body_entered.connect(_on_hit_box_body_entered)
	hit_box.body_exited.connect(_on_hit_box_body_exited)
	death_timer.timeout.connect(_on_death_timer_timeout)
	knock_out_timer.timeout.connect(_on_knock_out_timer_timeout)

func _physics_process(delta: float) -> void:
	if is_colliding_with_ball && ball.is_just_kicked:
		_handle_ball_hit()

	if !is_dead and !is_knocked_out:
		var to_player= player.global_position - global_position
		velocity = to_player.normalized() * speed * delta
	
	move_and_slide()
	look_at(player.global_position)


func _on_hit_box_body_entered(body: Node3D) -> void:
	if is_dead || is_knocked_out:
		return
		
	if body is Ball:
		is_colliding_with_ball = true
		_handle_ball_hit()


func _on_hit_box_body_exited(body):
	if body is Ball:
		is_colliding_with_ball = false


func _handle_ball_hit():

	var ball_velocity_length = ball.linear_velocity.length()
	var impulse_direction = ball.global_position.direction_to(global_position)
	var impulse = impulse_direction * ball_velocity_length * ball.hit_force
	_get_knocked_out(0.5)

	if ball.is_just_kicked || impulse.length() > death_threshold:
		if not is_dead:
			hit_audio.play()
			_die()

	velocity += impulse


func _die():
	is_dead = true
	velocity.y += randi_range(5, 10)
	death_timer.start()
	# collision_shape.disabled = true
	call_deferred("_disable_collision")
	anim_player.play("Defeat")
	world.handle_enemy_death(position)
	world.enemy_count -= 1

func _disable_collision():
	collision_shape.disabled = true
	
func _get_knocked_out(duration: float) -> void:
	is_knocked_out = true
	knock_out_timer.wait_time = duration
	knock_out_timer.start()

func _on_death_timer_timeout() -> void:
	queue_free()

func _on_knock_out_timer_timeout():
	is_knocked_out = false


