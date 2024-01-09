class_name MainButton extends TextureButton

var tap_audio: AudioStreamPlayer
# var label: Label

func _ready():
	tap_audio = get_node("TapAudio")
	# label = get_node("Label")
	# label.set("theme_override_colors/font_color", Color(0, 0, 0))


func _on_button_down():
	tap_audio.play()
