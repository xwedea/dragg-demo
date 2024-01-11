class_name ButtonControl extends Control

@onready var tap_audio := get_node("TapAudio") as AudioStreamPlayer
@onready var button := get_node("Button") as Button 


func _ready():
	pass


func _on_button_down():
	scale = Vector2(0.9, 0.9)
	tap_audio.play()
