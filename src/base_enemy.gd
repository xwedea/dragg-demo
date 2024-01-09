class_name BaseEnemy extends CharacterBody3D

@export var death_threshold: float = 30
var is_dead: bool = false
var is_knocked_out = false
var is_ball_colliding = false

var world: World
var ball: Ball
var death_timer: Timer
var knock_out_timer: Timer
var nav_agent: NavigationAgent3D
var player: BaseCharacter
var anim_player: AnimationPlayer
var model: Node3D
var collision_shape: CollisionShape3D
var hit_audio: AudioStreamPlayer

func _ready():
	world = get_tree().root.get_node("World3D") as World
	player = world.get_node("Player") as BaseCharacter
	ball = world.get_node("Ball") as Ball
	nav_agent = get_node("NavigationAgent3D") as NavigationAgent3D
	death_timer = get_node("DeathTimer") as Timer
	knock_out_timer = get_node("KnockOutTimer") as Timer
	model = get_node("Model") as Node3D
	collision_shape = get_node("CapsuleCollision") as CollisionShape3D
	hit_audio = get_node("HitAudio") as AudioStreamPlayer

	anim_player = model.get_node("AnimationPlayer") as AnimationPlayer
	anim_player.play("Run")
	


func _physics_process(_delta: float) -> void:
	if is_ball_colliding && ball.is_just_kicked:
		_handle_ball_hit()

	if !is_dead and !is_knocked_out:
		nav_agent.target_position = player.global_position
		var nextPathPosition: Vector3 = nav_agent.get_next_path_position()
		var direction: Vector3 = nextPathPosition - global_position
		velocity = direction * 0.5

	move_and_slide()
	look_at(player.global_position)


func _on_HitBox_body_entered(body: Node3D) -> void:
	if is_dead || is_knocked_out:
		return
		
	if body is Ball:
		is_ball_colliding = true
		_handle_ball_hit()


func _on_hit_box_body_exited(body):
	if body is Ball:
		is_ball_colliding = false


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

func _disable_collision():
	collision_shape.disabled = true
	

func _get_knocked_out(duration: float) -> void:
	is_knocked_out = true
	knock_out_timer.wait_time = duration
	knock_out_timer.start()


func _on_DeathTimer_timeout() -> void:
	queue_free()


func _on_knock_out_timer_timeout():
	is_knocked_out = false


