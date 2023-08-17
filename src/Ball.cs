using Godot;
using System;


public partial class Ball : RigidBody3D
{

	[Export] public float MaxKickDistance = 8;
	[Export] public float LineLength = 5;
	[Export] public float PullForce = 10;

	Node3D World;
	BaseCharacter Player;
	MeshInstance3D PreviousLine;
	Color LineColor;

	public override void _Ready()
	{
		World = GetTree().Root.GetNode<Node3D>("World3D");
		Player = World.GetNode<BaseCharacter>("BaseCharacter");	

		LineColor = Colors.Red;
		PreviousLine = LineDrawer.Draw3DLines(GlobalPosition, Player.GlobalPosition, LineColor);
	}

	public override void _PhysicsProcess(double delta)
	{
		DrawRope();
	}

	public void DrawRope() {
		float distance = Position.DistanceTo(Player.Position);

		if (distance < MaxKickDistance / 2) {
			LineColor = Colors.Red;
		}
		else if (distance < MaxKickDistance / 1.3) {
			LineColor = Colors.OrangeRed;
		}
		else if (distance < MaxKickDistance) {
			LineColor = Colors.Orange;
		}
		else {
			LineColor = Colors.White;
		}
		
		MeshInstance3D line = LineDrawer.Draw3DLines(GlobalPosition, Player.GlobalPosition, LineColor);
		World.AddChild(line);
		PreviousLine.QueueFree();

		PreviousLine = line;
	}


}
