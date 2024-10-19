class_name BaseCharacter extends CharacterBody3D

@onready var world := get_tree().root.get_node("World3D") as World
@onready var model := get_node("Model") as Node3D
@onready var ball := world.get_node("Ball") as Ball
@onready var anim_player := model.get_node("AnimationPlayer") as AnimationPlayer 
@onready var health_bar := get_node("HealthBar3D/SubViewport/HealthBar") as ProgressBar
@onready var hit_timer := get_node("HitBox/HitTimer") as Timer
@onready var nav_agent := get_node("NavigationAgent3D") as NavigationAgent3D
@onready var hit_box := get_node("HitBox") as Area3D
@onready var pull_area := get_node("PullArea") as Area3D

@export var walk_speed := 5
@export var kick_force := 100
@export var max_health := 100

static var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var health: float
var just_got_damaged := false
var is_moving := false 
var is_dead := false
var stick_center: Vector2
var stick_is_active := false

func _ready():
	anim_player.play("Idle")
	
	var sub_viewport = get_node("HealthBar3D/SubViewport") as SubViewport
	sub_viewport.set_update_mode(SubViewport.UPDATE_WHEN_PARENT_VISIBLE)

	health = max_health
	health_bar.value = health

	hit_box.body_entered.connect(_on_hit_box_body_entered)
	hit_box.area_entered.connect(_on_hit_box_area_entered)
	pull_area.area_entered.connect(_on_pull_area_area_entered)
	hit_timer.timeout.connect(_on_hit_timer_timeout)


func _physics_process(delta):
	if is_dead:
		return

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
	if is_moving: return
	if ball.player_in_active_area: return

	var distance = position.distance_to(ball.position);
	var to_ball = position.direction_to(ball.position).normalized();
	to_ball.y = 0;
	var distance_to_target = max(distance, 1)
	var multiplier = log(distance_to_target)
	var dragImpulse = to_ball * (ball.pull_force * multiplier)

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
	if !is_moving or !is_on_floor:
		return Vector3.ZERO;
		
	var stick_direction = stick_center.direction_to(get_viewport().get_mouse_position());
	return Vector3(stick_direction.x, 0, stick_direction.y);

func _handle_stick() -> void:
	if get_tree().paused: return
	if world.movement_disabled: return

func handle_left_mouse_pressed():
	is_moving = true;
	stick_center = get_viewport().get_mouse_position();
	stick_is_active = true

func handle_left_mouse_released():
	is_moving = false;

	if stick_is_active:
		var distance : float = position.distance_to(ball.position);
		if (distance < ball.max_kick_distance):
			ball.kick()
	
	stick_is_active = false

func die():
	is_dead = true
	anim_player.play("Defeat")
	world.handle_player_death()

func _on_hit_box_body_entered(body:Node3D):
	if just_got_damaged || is_dead: return

	if body is BaseEnemy:
		just_got_damaged = true
		hit_timer.start()
		health -= 35
		health_bar.value = health
		if health <= 0:
			die()
		
func _on_hit_timer_timeout():
	just_got_damaged = false


func _on_pull_area_area_entered(area:Area3D):
	var object = area.get_parent() as Pullable
	object.start_pulling()

func _on_hit_box_area_entered(area:Area3D):
	if is_dead: return
	
	var area_parent = area.get_parent()
	if area_parent is Pullable:
		world.play_coin_collect_audio()
		world.coins_collected += 1
		area_parent.queue_free()
		
