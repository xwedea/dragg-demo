using Godot;
using System;

public partial class BallRope : Node3D
{

	Node3D World;
	BaseCharacter Player;
	RigidBody3D Ball;

	Node3D BallRopeSlot;
	Skeleton3D RopeSkeleton;
	BoneAttachment3D FirstBone;
	BoneAttachment3D LastBone;

	public override void _Ready()
	{
		World = GetTree().Root.GetNode<Node3D>("World3D");
		Player = World.GetNode<BaseCharacter>("BaseCharacter");	
		Ball = World.GetNode<RigidBody3D>("Ball");
		BallRopeSlot = Ball.GetNode<Node3D>("RopeSlot");

		RopeSkeleton = GetNode<Skeleton3D>("Armature/Skeleton3D");
		RopeSkeleton.PhysicalBonesStartSimulation();

		FirstBone = RopeSkeleton.GetNode<BoneAttachment3D>("Bone");
		// FirstBone.OverridePose = true;
		// FirstBone.GlobalPosition = BallRopeSlot.GlobalPosition;

		LastBone = RopeSkeleton.GetNode<BoneAttachment3D>("Bone6");
		// LastBone.OverridePose = true;
		// LastBone.GlobalPosition = Player.GlobalPosition;
	}

	public override void _Process(double delta)
	{
		// FirstBone.GlobalPosition = BallRopeSlot.GlobalPosition;
		// LastBone.GlobalPosition = Player.GlobalPosition;
	}
}
