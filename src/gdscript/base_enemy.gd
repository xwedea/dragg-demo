class_name BaseEnemy extends CharacterBody3D

@export var DeathThreshold: float = 15.0
var isDead: bool = false

var World: Node3D
var DeathTimer: Timer
var NavAgent: NavigationAgent3D
var Player: BaseCharacter

func _ready():
	World = get_tree().root.get_node("World3D") as Node3D
	NavAgent = get_node("NavigationAgent3D") as NavigationAgent3D
	DeathTimer = get_node("DeathTimer") as Timer
	Player = World.get_node("BaseCharacter") as BaseCharacter

func _physics_process(delta: float) -> void:
	if !isDead:
		NavAgent.target_position = Player.global_position
		var nextPathPosition: Vector3 = NavAgent.get_next_path_position()
		var direction: Vector3 = nextPathPosition - global_position
		velocity = direction * 0.5

	move_and_slide()
	look_at(Player.global_position)

func _on_HitBox_body_entered(body: Node3D) -> void:
	if isDead:
		return

	if body is Ball:
		var ball: Ball = body as Ball
		var ballVelocityLength: float = ball.linear_velocity.length()
		var impulseDirection: Vector3 = ball.global_position.direction_to(global_position)
		var impulse: Vector3 = impulseDirection * ball.linear_velocity.length() * 1.5

		if ballVelocityLength > DeathThreshold:
			impulse.y += 15
			isDead = true
			DeathTimer.start()

			global_rotation = Vector3(20, 20, 20)

		velocity += impulse

func _on_DeathTimer_timeout() -> void:
	queue_free()
