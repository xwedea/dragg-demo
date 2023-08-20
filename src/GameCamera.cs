using Godot;
using System;

public partial class GameCamera : Camera3D
{

	Node3D World;
	Node3D Character;
	Node3D CharacterCameraController;

	public override void _Ready()
	{
		World = GetTree().Root.GetNode<Node3D>("World3D");
		Character = World.GetNode<Node3D>("BaseCharacter");
		CharacterCameraController = Character.GetNode<Node3D>("CameraController");
	}

	public override void _PhysicsProcess(double delta)
	{
		Vector3 newPosition = Position.Lerp(CharacterCameraController.GlobalPosition, 0.1f);
		Position = newPosition;

	}
}
