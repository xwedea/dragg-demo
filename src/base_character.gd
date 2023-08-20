class_name BaseCharacter extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var walk_speed : float = 5

var is_moving : bool = false
var stick_center : Vector2

var world : Node3D
var model : Node3D
var ball : Ball
var anim_player : AnimationPlayer


func _ready():
	world = get_tree().root.get_node("World3D")
	model = get_node("Model")
	ball = world.get_node("Ball") as Ball
	anim_player = model.get_node("AnimationPlayer")
	anim_player.play("Idle")
	

func _physics_process(delta):
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

	
func _kick() -> void:
	var distance : float = position.distance_to(ball.position);
	if (distance < ball.max_kick_distance): 
		var toBall = position.direction_to(ball.position);
		toBall.y = 0;
		var force = 120/distance;
		var ballImpulse = force * toBall;
		ball.apply_impulse(ballImpulse);


func _get_dragged() -> void: 
	var distance = position.distance_to(ball.position);
	if (distance > ball.line_length):
		var toBall = position.direction_to(ball.position).normalized();
		var force = 3;
		var dragImpulse = toBall * force;
		velocity += dragImpulse;
			

func _handle_animations() -> void:
	var currentAnim = anim_player.current_animation;
	
	if (is_moving):
		if (currentAnim != "Run"):
			anim_player.play("Run");
	else:
		if (currentAnim != "Idle"):
			anim_player.play("Idle");

	
func _get_movement() -> Vector3:
	if (!is_moving):
		return Vector3.ZERO;
		
	var stickDirection = stick_center.direction_to(get_viewport().get_mouse_position());
	return Vector3(stickDirection.x, 0, stickDirection.y);


func _handle_stick() -> void:
	if (Input.is_action_just_pressed("LeftClick")):
		is_moving = true;
		stick_center = get_viewport().get_mouse_position();
	elif (Input.is_action_just_released("LeftClick")):
		is_moving = false;
		_kick();
