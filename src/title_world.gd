extends Node3D

@onready var background_audio := get_node("BackgroundAudio") as AudioStreamPlayer
@onready var signin_label := get_node("UI/SignInLabel") as Label

var _sign_in_retries := 3
var gpgs = GodotPlayGameServices.android_plugin

func _ready():
	if background_audio:
		background_audio.play()
		
	play_games_login()

func play_games_login():
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
			signin_label.text = "Login Succesful!"
	)

	PlayersClient.current_player_loaded.connect(func(play_games_player: PlayersClient.PlayGamesPlayer):
		print('current_player_loaded connected')
		signin_label.text = 'Welcome ' + play_games_player.display_name + '!'
	)

	get_tree().create_timer(3).timeout.connect(func():
		PlayersClient.load_current_player(false)
		print('current_player_loaded emitted')
	)

