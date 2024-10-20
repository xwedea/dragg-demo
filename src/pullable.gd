class_name Pullable extends Node3D

@onready var world := get_tree().root.get_node("World3D") as Node3D
@onready var player := world.get_node("Player") as BaseCharacter
@onready var collect_audio := get_node("CollectAudio") as AudioStreamPlayer

var is_getting_pulled: bool = false

func _process(delta):
	if is_getting_pulled:
		var weight =  12 * delta
		position = position.move_toward(player.position + Vector3(0, 1, 0), weight)


func start_pulling():
	is_getting_pulled = true

