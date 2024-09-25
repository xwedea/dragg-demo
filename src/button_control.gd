class_name ButtonControl extends Control

@onready var texture_button := get_node("TextureButton") as TextureButton
static var tap_audio_stream := preload("res://assets-dragg/audio/punchy-taps-ui-5-183901.mp3") as AudioStream
var tap_audio : AudioStreamPlayer 

func _ready():
	# if tap_audio_stream.insat
	tap_audio = AudioStreamPlayer.new()
	tap_audio.stream = tap_audio_stream
	add_child(tap_audio)

	texture_button.button_down.connect(_on_button_down)
	texture_button.button_up.connect(_on_button_up)

func _on_button_down():
	scale = Vector2(0.9, 0.9)
	tap_audio.play()

func _on_button_up():
	scale = Vector2(1, 1)


