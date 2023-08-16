using Godot;
using System;

public partial class BaseEnemy : CharacterBody3D
{

	[Export] float DeathThreshold = 15f;
	bool isDead = false;

	Node3D World;
	Timer DeathTimer;
	NavigationAgent3D NavAgent;
	BaseCharacter Player;

	public override void _Ready()
	{
		base._Ready();

		World = GetTree().Root.GetNode<Node3D>("World3D");
		NavAgent = GetNode<NavigationAgent3D>("NavigationAgent3D");
		DeathTimer = GetNode<Timer>("DeathTimer");
		Player = World.GetNode<BaseCharacter>("BaseCharacter");

	}

	public override void _PhysicsProcess(double delta)
	{
		Vector3 velocity = Velocity;

		if (!isDead) {
			NavAgent.TargetPosition = Player.GlobalPosition;
			Vector3 nextPathPosition = NavAgent.GetNextPathPosition();
			Vector3 direction = nextPathPosition - GlobalPosition;
			velocity = direction * 0.5f;
		}
		
		// 	velocity.X = Mathf.MoveToward(velocity.X, 0, (float) delta * 10);
		// 	velocity.Z = Mathf.MoveToward(velocity.Z, 0, (float) delta * 10);
		// }

		Velocity = velocity;
		MoveAndSlide();
	}

	private void OnHitBoxBodyEntered(Node3D body)
	{
		if (isDead) return;

		if (body is Ball) {
			Ball ball = (Ball) body;
			float ballVelocityLength = ball.LinearVelocity.Length(); 
			Vector3 impulseDirection = ball.Position.DirectionTo(Position);
			Vector3 impulse = impulseDirection * ball.LinearVelocity.Length() * 1.5f;

			GD.Print(ballVelocityLength);
			if (ballVelocityLength > DeathThreshold) {
				impulse.Y += 15;
				isDead = true;
				DeathTimer.Start();
			}
			
			Velocity += impulse;
		}

	}


	private void OnDeathTimerTimeout()
	{
		GD.Print("freed");
		QueueFree();
	}

}


