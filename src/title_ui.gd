extends Node

@onready var title_world := get_tree().root.get_node("TitleWorld")
@onready var title_scene := title_world.get_node("TitleScene") as Node3D
@onready var play_button := get_node("PlayButton") as ButtonControl
@onready var guide_button := get_node("GuideButton") as ButtonControl
@onready var guide_button_label := get_node("GuideButton/Label") as Label
@onready var learn_info := get_node("Guide/LearnInfo") as Control

var learn_button_text

func _ready():
	title_scene.visible = true
	learn_info.visible = false
	learn_button_text = guide_button_label.text

	play_button.texture_button.pressed.connect(_on_play_button_pressed)
	guide_button.texture_button.toggled.connect(_on_learn_button_toggled)

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://world/game_world.tscn")

func _on_learn_button_toggled(toggled_on):
	learn_info.visible = toggled_on
	title_scene.visible = not toggled_on
	guide_button_label.text = "Home" if toggled_on else learn_button_text
