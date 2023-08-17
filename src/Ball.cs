using Godot;
using System;


public partial class Ball : RigidBody3D
{

	[Export] public float Power = 10;

	Node3D World;
	BaseCharacter Player;

	public override void _Ready()
	{
		
		World = GetTree().Root.GetNode<Node3D>("World3D");
		Player = World.GetNode<BaseCharacter>("BaseCharacter");	

	}

	public override void _Process(double delta)
	{
		
	}

}
