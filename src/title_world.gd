extends Node3D

@onready var background_audio := get_node("BackgroundAudio") as AudioStreamPlayer
@onready var signin_label := get_node("UI/SignInLabel") as Label

func _ready():
	if background_audio:
		background_audio.play()

	print("title ready()")
	SignInClient.user_authenticated.connect(_on_user_authenticated)

func _on_user_authenticated(is_authenticated):
	signin_label.text = "is authenticated: " + str(is_authenticated)

	if not is_authenticated:
		SignInClient.sign_in()
	

func _on_user_signed_in():
	print("signed in")



