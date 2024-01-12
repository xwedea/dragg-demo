class_name TitleCharacter extends CharacterBody3D

@onready var world := get_tree().root.get_node("World3D") as World
@onready var model := get_node("Model") as Node3D
@onready var anim_player := model.get_node("AnimationPlayer") as AnimationPlayer 
@onready var death_timer := get_node("TurnTimer") as Timer

var waved 

func _ready():
	anim_player.play("Wave")


func _handle_animations() -> void:
	var current_anim = anim_player.current_animation;
	
	if (current_anim != "Wave"):
		anim_player.play("Wave");

	
