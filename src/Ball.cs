using Godot;
using System;
using System.Security.Cryptography.X509Certificates;


public partial class Ball : RigidBody3D
{

	float Deceleration = 2;
	public float Power = 10;
	public float currentSpeed = 0;

	public override void _Ready()
	{

	}

	public override void _Process(double delta)
	{
		// LinearVelocity = LinearVelocity.MoveToward(Vector3.Zero, 0.5f);
		// currentSpeed = Line
	}
}
