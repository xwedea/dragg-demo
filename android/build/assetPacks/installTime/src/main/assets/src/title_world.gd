extends Node3D

@onready var background_audio := get_node("BackgroundAudio") as AudioStreamPlayer


func _ready():
	background_audio.play()

