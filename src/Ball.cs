using Godot;
using System;


public partial class Ball : RigidBody3D
{

	[Export] public float MaxKickDistance = 8;
	[Export] public float LineLength = 5;
	[Export] public float PullForce = 10;
	[Export] float RopeThickness = 0.1f;
	[Export] Color RopeColor;
	[Export] bool OverrideRopeColor = false;

	Node3D World;
	BaseCharacter Player;
	MeshInstance3D PreviousRope;

	public override void _Ready()
	{
		World = GetTree().Root.GetNode<Node3D>("World3D");
		Player = World.GetNode<BaseCharacter>("BaseCharacter");	

		if (!OverrideRopeColor) RopeColor = Colors.Red;
		PreviousRope = LineDrawer.CreateLineMesh(GlobalPosition, Player.GlobalPosition, RopeThickness, RopeColor);
	}

	public override void _PhysicsProcess(double delta)
	{
		DrawRope();
	}

	public void DrawRope() {
		if (!OverrideRopeColor) {
			float distance = Position.DistanceTo(Player.Position);

			if (distance < MaxKickDistance / 2) {
				RopeColor = Colors.Red;
			}
			else if (distance < MaxKickDistance / 1.3) {
				RopeColor = Colors.OrangeRed;
			}
			else if (distance < MaxKickDistance) {
				RopeColor = Colors.Orange;
			}
			else {
				RopeColor = Colors.White;
			}
		}
		
		MeshInstance3D line = LineDrawer.CreateLineMesh(GlobalPosition, Player.GlobalPosition, RopeThickness, RopeColor);
		World.AddChild(line);
		PreviousRope.QueueFree();

		PreviousRope = line;
	}


}
