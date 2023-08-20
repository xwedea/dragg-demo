class_name BaseEnemy extends CharacterBody3D

@export var death_threshold: float = 15.0
var is_dead: bool = false

var world: Node3D
var death_timer: Timer
var nav_agent: NavigationAgent3D
var player: BaseCharacter

func _ready():
	world = get_tree().root.get_node("World3D") as Node3D
	nav_agent = get_node("NavigationAgent3D") as NavigationAgent3D
	death_timer = get_node("DeathTimer") as Timer
	player = world.get_node("BaseCharacter") as BaseCharacter

func _physics_process(_delta: float) -> void:
	if !is_dead:
		nav_agent.target_position = player.global_position
		var nextPathPosition: Vector3 = nav_agent.get_next_path_position()
		var direction: Vector3 = nextPathPosition - global_position
		velocity = direction * 0.5

	move_and_slide()
	look_at(player.global_position)

func _on_HitBox_body_entered(body: Node3D) -> void:
	if is_dead:
		return

	if body is Ball:
		var ball: Ball = body as Ball
		var ballVelocityLength: float = ball.linear_velocity.length()
		var impulseDirection: Vector3 = ball.global_position.direction_to(global_position)
		var impulse: Vector3 = impulseDirection * ball.linear_velocity.length() * 1.5

		if ballVelocityLength > death_threshold:
			impulse.y += 15
			is_dead = true
			death_timer.start()

			global_rotation = Vector3(20, 20, 20)

		velocity += impulse

func _on_DeathTimer_timeout() -> void:
	queue_free()
