using Godot;
using System;


public partial class BaseCharacter : CharacterBody3D
{
	[Export] float WalkSpeed = 5f;

	public float gravity = ProjectSettings.GetSetting("physics/3d/default_gravity").AsSingle();

	Node3D World;
	AnimationPlayer AnimPlayer;
	Node3D Model;
	Ball Ball;
	GameCamera Camera;

	Vector2 StickCenter;
	bool IsMoving = false;

	public override void _Ready()
	{
		base._Ready();
   
		World = GetTree().Root.GetNode<Node3D>("World3D");
		Model = GetNode<Node3D>("Model");
		Ball = World.GetNode<Ball>("Ball");
		Camera = World.GetNode<GameCamera>("GameCamera");
		AnimPlayer = Model.GetNode<AnimationPlayer>("AnimationPlayer");
		AnimPlayer.Play("Idle");
	}

	public override void _PhysicsProcess(double delta)
	{
		HandleStick(); 

		Vector3 velocity = Velocity;

		// Add the gravity
		if (!IsOnFloor())
			velocity.Y -= gravity * (float)delta;

		// Handle Movement
		Vector3 direction = GetMovement();
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
		MoveAndSlide();
		
		// Handle graphics
		HandleAnimations();

		if (direction.Length() > 0) {
			Vector3 faceDirection = Transform.Origin + Velocity.Normalized() * 10;
			Model.LookAt(faceDirection);
		}
	}

	private void Kick() {
		float distance = Position.DistanceTo(Ball.Position);
		if (distance < 5) {
			Vector3 toBall = Position.DirectionTo(Ball.Position);
			toBall.Y = 0;
			float force = 120/distance;
			Vector3 ballImpulse = force * toBall;

			Ball.ApplyImpulse(ballImpulse);
		}
	}


	private void BallDragging() {
		float distance = Position.DistanceTo(Ball.Position);

		if (distance > 5) {
			Vector3 toBall = Position.DirectionTo(Ball.Position);
			double force = 3;

			Vector3 dragImpulse = toBall * (float) force;
			Velocity += dragImpulse;
		}

	}

	private void HandleAnimations() {
		string currentAnim = AnimPlayer.CurrentAnimation;

		if (IsMoving) {
			if (currentAnim != "Run") {
				AnimPlayer.Play("Run");
			}
		}
		else {
			if (currentAnim != "Idle") {
				AnimPlayer.Play("Idle");
			}
		}
	}
	
	private Vector3 GetMovement() {
		if (!IsMoving) {
			return Vector3.Zero;
		}

		Vector2 mousePosition = GetViewport().GetMousePosition();
		Vector2 stickDirection = StickCenter.DirectionTo(mousePosition);

		Vector3 velocity = Vector3.Zero;
		velocity.Z = stickDirection.Y;
		velocity.X = stickDirection.X;

		return velocity;
	}


	private void HandleStick() {
		if (Input.IsActionJustPressed("LeftClick")) {
			IsMoving = true;
			StickCenter = GetViewport().GetMousePosition();
		}
		else if (Input.IsActionJustReleased("LeftClick")) {
			IsMoving = false;
			Kick();
		}
	}




}