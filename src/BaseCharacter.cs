using Godot;
using System;


public partial class BaseCharacter : CharacterBody3D
{
	public const float Acceleration = 0.05f;
	public const float WalkSpeed = 5f;
	public const float JumpVelocity = 4.5f;
	public const float WalkSpeedLimit = 3f;
	public const float MaxSpeed = 20f;

	public float gravity = ProjectSettings.GetSetting("physics/3d/default_gravity").AsSingle();

	AnimationPlayer AnimPlayer;
	Node3D Model;
	Ball Ball;

	public override void _Ready()
	{
		base._Ready();
   
		Model = GetNode<Node3D>("Model");
		Ball = GetTree().Root.GetNode<Ball>("World3D/Ball");
		AnimPlayer = Model.GetNode<AnimationPlayer>("AnimationPlayer");
		AnimPlayer.Play("Idle");
	}

	public override void _PhysicsProcess(double delta)
	{
		Vector3 velocity = Velocity;

		// Add the gravity.
		if (!IsOnFloor())
			velocity.Y -= gravity * (float)delta;

		// Handle Jump.
		if (Input.IsActionJustPressed("ui_accept") && IsOnFloor())
			velocity.Y = JumpVelocity;

		Vector3 direction = Vector3.Zero;
		if (Input.IsActionPressed("MoveForward")) {
			direction.Z -= 1;
		}
		if (Input.IsActionPressed("MoveBackward")) {
			direction.Z += 1;
		}
		if (Input.IsActionPressed("MoveRight")) {
			direction.X += 1;
		}
		if (Input.IsActionPressed("MoveLeft")) {
			direction.X += -1;
		}

		if (direction != Vector3.Zero)
		{
			velocity = direction * WalkSpeed;
		}
		else
		{
			velocity.X = Mathf.MoveToward(Velocity.X, 0, 2);
			velocity.Z = Mathf.MoveToward(Velocity.Z, 0, 2);
		}

		Velocity = velocity;
		BallDragging();

		if (Velocity.Length() > MaxSpeed) {
			Velocity = Velocity.Normalized() * MaxSpeed;
		}

		MoveAndSlide();

		
		if (direction.Length() > 0) {
			Vector3 faceDirection = Transform.Origin + direction;
			Model.LookAt(faceDirection);
		}

		// HandleAnimations();
	}


	public override void _UnhandledInput(InputEvent @event)
	{
		base._UnhandledInput(@event);

		float distance = Position.DistanceTo(Ball.Position);
		if (distance < 5) {
			Vector3 toBall = Position.DirectionTo(Ball.Position);
			toBall.Y = 0;
			float force = 120/distance;
			Vector3 ballImpulse = force * toBall;

			if (Input.IsActionJustPressed("Kick")) {
				Ball.ApplyImpulse(ballImpulse);
			}
		}

	}

	private void BallDragging() {
		float distance = Position.DistanceTo(Ball.Position);

		if (distance > 5) {
			Vector3 toBall = Position.DirectionTo(Ball.Position);
			// double force = Math.Pow(distance/2, 2);
			// double force = distance / 5;
			double force = 3;

			Vector3 dragImpulse = toBall * (float) force;
			Velocity += dragImpulse;
		}

	}

	private void HandleAnimations() {
		string currentAnim = AnimPlayer.CurrentAnimation;

		Vector3 velocityXZ = Velocity;
		velocityXZ.Y = 0;

		if (velocityXZ.Length() > 0 && currentAnim != "Run") {
			AnimPlayer.Play("Run");
		}
		else if (Velocity.Length() == 0) {
			if (currentAnim != "Idle") {
				AnimPlayer.Play("Idle");
			}
		}
	}

	
}
