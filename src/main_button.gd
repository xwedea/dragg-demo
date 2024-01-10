class_name MainButton extends TextureButton

var tap_audio: AudioStreamPlayer


func _ready():
	tap_audio = get_node("TapAudio")


func _on_button_down():
	tap_audio.play()
