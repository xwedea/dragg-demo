using Godot;
using System;
using System.Collections.Generic;


public partial class Game3D : Node3D
{
	private List<BaseCharacter> SelectedCharacters = new();
	Camera3D Camera;

	public override void _Ready()
	{
		// Camera = GetNode<Camera3D>("Camera3D");

	}

	public override void _Process(double delta)
	{
	}


	public override void _UnhandledInput(InputEvent @event)
	{

		if (Input.IsActionJustPressed("Ctrl + LeftClick")) {
			// a
		}
		else if (Input.IsActionJustPressed("LeftClick")) {
			HandleLeftClick();
			
		}

		if (Input.IsActionJustPressed("RightClick")) {
			//
		}
	}

	private void HandleLeftClick() {
		//
	}

}
