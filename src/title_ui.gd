extends Node

@onready var title_world := get_tree().root.get_node("TitleWorld")
@onready var title_scene := title_world.get_node("TitleScene") as Node3D
@onready var play_button := get_node("Home/PlayButton") as ButtonControl
@onready var home_button := get_node("HomeButton") as ButtonControl
@onready var profile_button := get_node("ProfileButton") as ButtonControl
@onready var guide_button := get_node("GuideButton") as ButtonControl
@onready var learn_info := get_node("Guide/LearnInfo") as Control
@onready var home := get_node("Home") as Control
@onready var profile := get_node("Profile") as Control
@onready var guide := get_node("Guide") as Control 
@onready var red_hexagon_image := preload("res://assets-dragg/casual_ui/button/Btn_OtherButton_Hexagon01_Red.png")
@onready var blue_hexagon_image := preload("res://assets-dragg/casual_ui/button/Btn_OtherButton_Hexagon01_Blue.png")

func _ready():
	title_scene.visible = true
	home.visible = true
	profile.visible = false
	guide.visible = false
	home_button.texture_button.texture_normal = red_hexagon_image
	profile_button.texture_button.texture_normal = blue_hexagon_image
	guide_button.texture_button.texture_normal = blue_hexagon_image

	play_button.texture_button.pressed.connect(_on_play_button_pressed)
	guide_button.texture_button.pressed.connect(_on_guide_button_pressed)
	home_button.texture_button.pressed.connect(_on_home_button_pressed)
	profile_button.texture_button.pressed.connect(_on_profile_button_pressed)

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://world/game_world.tscn")

func _on_guide_button_pressed():
	guide.visible = true
	home.visible = false
	profile.visible = false
	title_scene.visible = false
	guide_button.texture_button.texture_normal = red_hexagon_image
	home_button.texture_button.texture_normal = blue_hexagon_image
	profile_button.texture_button.texture_normal = blue_hexagon_image

func _on_home_button_pressed():
	title_scene.visible = true
	home.visible = true
	guide.visible = false
	profile.visible = false
	guide_button.texture_button.texture_normal = blue_hexagon_image
	home_button.texture_button.texture_normal = red_hexagon_image
	profile_button.texture_button.texture_normal = blue_hexagon_image

func _on_profile_button_pressed():
	profile.visible = true
	home.visible = false
	title_scene.visible = false
	guide.visible = false
	guide_button.texture_button.texture_normal = blue_hexagon_image
	home_button.texture_button.texture_normal = blue_hexagon_image
	profile_button.texture_button.texture_normal = red_hexagon_image