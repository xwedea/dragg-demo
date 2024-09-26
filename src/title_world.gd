extends Node3D

@onready var background_audio := get_node("BackgroundAudio") as AudioStreamPlayer
@onready var signin_label := get_node("UI/SignInLabel") as Label

var _sign_in_retries := 5

func _ready():
	if background_audio:
		background_audio.play()

	if not GodotPlayGameServices.android_plugin:
		signin_label.text = "Plugin Not Found!"
	
	SignInClient.user_authenticated.connect(func(is_authenticated: bool):
		if _sign_in_retries > 0 and not is_authenticated:
			signin_label.text = "Trying to sign in!"
			SignInClient.sign_in()
			_sign_in_retries -= 1
		
		if _sign_in_retries == 0:
			signin_label.text = "Sign in attemps expired!"
		
		if is_authenticated:
			signin_label.text = "Authenticated!"
	)

func _on_user_authenticated(is_authenticated):
	_update_signin_label("is authenticated: " + str(is_authenticated))

	if not is_authenticated:
		SignInClient.sign_in()
	

func _on_user_signed_in():
	print("signed in")

func _update_signin_label(text):
	signin_label.text = text



