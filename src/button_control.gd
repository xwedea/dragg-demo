class_name ButtonControl extends Control

@onready var tap_audio := get_node("TapAudio") as AudioStreamPlayer
@onready var texture_button := get_node("TextureButton") as TextureButton

func _ready():
	pass
	

func _on_texture_button_button_down():
	scale = Vector2(0.9, 0.9)
	tap_audio.play()


func _on_texture_button_button_up():
	scale = Vector2(1, 1)


