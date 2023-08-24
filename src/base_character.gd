class_name BaseCharacter extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var walk_speed : int = 5
@export var kick_force : int = 150
@export var max_health : int = 100

var health : float
var just_got_damaged : bool = false
var is_moving : bool = false
var is_dead : bool = false
var stick_center : Vector2

var world : Node3D
var model : Node3D
var ball : Ball
var anim_player : AnimationPlayer
var rope_slot : Node3D
var health_bar : ProgressBar
var hit_timer : Timer
var death_timer : Timer


func _ready():
	world = get_tree().root.get_node("World3D") as Node3D
	model = get_node("Model") as Node3D
	ball = world.get_node("Ball") as Ball
	rope_slot = get_node("RopeSlot") as Node3D
	health_bar = get_node("HealthBar3D/SubViewport/HealthBar") as ProgressBar
	hit_timer = get_node("HitBox/HitTimer") as Timer
	death_timer = get_node("DeathTimer") as Timer
	anim_player = model.get_node("AnimationPlayer") as AnimationPlayer 
	anim_player.play("Idle")
	
	health = max_health
	health_bar.value = health

func _physics_process(delta):
	if is_dead:
		return

	_handle_stick(); 

	var vel = velocity;

	if (!is_on_floor()):
		vel.y -= gravity * delta;

	var direction = _get_movement();
	if (direction != Vector3.ZERO):
		vel = direction * walk_speed;
	else:
		vel.x = move_toward(velocity.x, 0, 2);
		vel.z = move_toward(velocity.z, 0, 2);

	velocity = vel;
	_get_dragged();
	move_and_slide();
	
	_handle_animations();

	if (direction.length() > 0 && velocity.length() > 0.5):
		var faceDirection = transform.origin + velocity.normalized() * 10;
		model.look_at(faceDirection);


func _get_dragged() -> void: 
	var distance = position.distance_to(ball.position);
	if (distance > ball.line_length):
		var to_ball = position.direction_to(ball.position).normalized();
		to_ball.y = 0;
		var dragImpulse = to_ball * ball.pull_force;
		velocity += dragImpulse;
			

func _handle_animations() -> void:
	var current_anim = anim_player.current_animation;
	
	if (is_moving):
		if (current_anim != "Run"):
			anim_player.play("Run");
	else:
		if (current_anim != "Idle"):
			anim_player.play("Idle");

	
func _get_movement() -> Vector3:
	if (!is_moving):
		return Vector3.ZERO;
		
	var stick_direction = stick_center.direction_to(get_viewport().get_mouse_position());
	return Vector3(stick_direction.x, 0, stick_direction.y);


func _handle_stick() -> void:
	if (Input.is_action_just_pressed("LeftClick")):
		is_moving = true;
		stick_center = get_viewport().get_mouse_position();
	elif (Input.is_action_just_released("LeftClick")):
		is_moving = false;

		var distance : float = position.distance_to(ball.position);
		if (distance < ball.max_kick_distance):
			ball.kick(distance)


func _die():
	is_dead = true
	anim_player.play("Defeat")
	death_timer.start()


func _on_hit_box_body_entered(body:Node3D):
	if just_got_damaged || is_dead: return

	if body is BaseEnemy:
		just_got_damaged = true
		hit_timer.start()
		health -= 35
		health_bar.value = health
		if health <= 0:
			_die()


func _on_hit_timer_timeout():
	just_got_damaged = false


func _on_death_timer_timeout():
	# get_tree().change_scene("res://world/development_world.tscn")
	get_tree().reload_current_scene()

