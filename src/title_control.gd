extends Control

@onready var play_button := get_node("PlayButton")
@onready var tutorial_button := get_node("TutorialButton")
@onready var title_audio := get_node("TitleAudio")

# var casual_font_res := preload("res://ui/fonts/supercell-magic-webfont.ttf") as Font

func _ready():
	title_audio.play()
	# add_theme_font_override("casual", casual_font_res)

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://world/development_world.tscn")


