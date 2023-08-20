extends CharacterBody3D

@export var WalkSpeed : float = 5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var World : Node3D
var Model : Node3D
var Ball
var AnimPlayer : AnimationPlayer

var IsMoving : bool = false
var StickCenter

func _ready():
	World = get_tree().root.get_node("World")
	Model = get_node("Model")
	Ball = World.get_node("Ball")
	AnimPlayer = Model.get_node("AnimationPlayer")
	AnimPlayer.play("Idle")
	
func _physics_process(delta):
	HandleStick(); 

	var vel = velocity;

	if (!is_on_floor()):
		vel.Y -= gravity * delta;

	var direction = GetMovement();
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
		Model.LookAt(faceDirection);
	
func Kick():
	var distance : float = position.distance_to(Ball.Position);
	if (distance < Ball.MaxKickDistance): 
		var toBall = position.direction_to(Ball.Position);
		toBall.Y = 0;
		var force = 120/distance;
		var ballImpulse = force * toBall;
		Ball.ApplyImpulse(ballImpulse);


func GetDragged(): 
		var distance = position.distance_to(Ball.position);

		if (distance > Ball.LineLength):
			var toBall = position.direction_to(Ball.position);
			var force = 3;
			var dragImpulse = toBall * force;
			velocity += dragImpulse;
			

func HandleAnimations():
		var currentAnim = AnimPlayer.CurrentAnimation;

		if (IsMoving):
			if (currentAnim != "Run"):
				AnimPlayer.Play("Run");
		else:
			if (currentAnim != "Idle"):
				AnimPlayer.Play("Idle");

	
func GetMovement():
		if (!IsMoving):
			return Vector3.ZERO;

		var mousePosition = get_viewport().get_mouse_position();
		var stickDirection = StickCenter.direction_to(mousePosition);

		var velocity = Vector3.ZERO;
		velocity.Z = stickDirection.Y;
		velocity.X = stickDirection.X;

		return velocity;


func HandleStick():
		if (Input.is_action_just_pressed("LeftClick")):
			IsMoving = true;
			StickCenter = get_viewport().get_mouse_position();
		elif (Input.is_action_just_pressed("LeftClick")):
			IsMoving = false;
			Kick();
