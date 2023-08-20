class_name BaseCharacter extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var WalkSpeed : float = 5

var World : Node3D
var Model : Node3D
var ball : Ball
var AnimPlayer : AnimationPlayer

var IsMoving : bool = false
var StickCenter : Vector2

func _ready():
	World = get_tree().root.get_node("World3D")
	Model = get_node("Model")
	ball = World.get_node("Ball") as Ball
	AnimPlayer = Model.get_node("AnimationPlayer")
	AnimPlayer.play("Idle")
	
func _physics_process(delta):
	HandleStick(); 

	var vel = velocity;

	if (!is_on_floor()):
		vel.y -= gravity * delta;

	var direction = GetMovement();
	print(direction)
	if (direction != Vector3.ZERO):
		vel = direction * WalkSpeed;
	else:
		vel.x = move_toward(velocity.x, 0, 2);
		vel.z = move_toward(velocity.z, 0, 2);

	velocity = vel;
	GetDragged();
	move_and_slide();
	
	HandleAnimations();

	if (direction.length() > 0 && velocity.length() > 0.5):
		var faceDirection = transform.origin + velocity.normalized() * 10;
		Model.look_at(faceDirection);
	
func Kick():
	var distance : float = position.distance_to(ball.position);
	if (distance < ball.MaxKickDistance): 
		var toBall = position.direction_to(ball.position);
		toBall.y = 0;
		var force = 120/distance;
		var ballImpulse = force * toBall;
		print("impulse: ", ballImpulse)
		ball.apply_impulse(ballImpulse);


func GetDragged(): 
	var distance = position.distance_to(ball.position);
	if (distance > ball.LineLength):
		var toBall = position.direction_to(ball.position).normalized();
		var force = 3;
		var dragImpulse = toBall * force;
		velocity += dragImpulse;
			

func HandleAnimations():
	var currentAnim = AnimPlayer.current_animation;
	
	if (IsMoving):
		if (currentAnim != "Run"):
			AnimPlayer.play("Run");
	else:
		if (currentAnim != "Idle"):
			AnimPlayer.play("Idle");

	
func GetMovement() -> Vector3:
	if (!IsMoving):
		return Vector3.ZERO;
		
	var stickDirection = StickCenter.direction_to(get_viewport().get_mouse_position());
	return Vector3(stickDirection.x, 0, stickDirection.y);


func HandleStick() -> void:
	if (Input.is_action_just_pressed("LeftClick")):
		IsMoving = true;
		StickCenter = get_viewport().get_mouse_position();
	elif (Input.is_action_just_released("LeftClick")):
		IsMoving = false;
		Kick();
