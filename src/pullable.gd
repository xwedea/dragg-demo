class_name Pullable extends Node3D

var getting_pulled: bool = false

var world: Node3D
var player: BaseCharacter
var collect_audio: AudioStreamPlayer

func _ready():
	world = get_tree().root.get_node("World3D") as Node3D
	player = world.get_node("Player") as BaseCharacter
	collect_audio = get_node("CollectAudio") as AudioStreamPlayer


func _process(delta):
	if getting_pulled:
		var weight = 10 * delta
		position = position.move_toward(player.position, weight)


func start_pulling():
	getting_pulled = true

# func handle_player_hit():
# 	collect_audio.play()
# 	visible = false
# 	call_deferred("queue_free")
