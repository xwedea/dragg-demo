class_name Pullable extends Node3D

@onready var world := get_tree().root.get_node("World3D") as Node3D
@onready var player := world.get_node("Player") as BaseCharacter
@onready var collect_audio := get_node("CollectAudio") as AudioStreamPlayer

var getting_pulled: bool = false

func _process(delta):
	if getting_pulled:
		var weight =  12 * delta
		position = position.move_toward(player.position, weight)


func start_pulling():
	getting_pulled = true

