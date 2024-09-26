extends Node

# func _ready():
	# var gpgs = GodotPlayGameServices.android_plugin
	# pass
	# if Engine.has_singleton("GodotPlayGameServices"):

func _input(_event):
	if Input.is_action_just_pressed("C"):
		print("c amk")
		var screenshot = get_viewport().get_texture().get_image()
		while true:
			var random_number = randi_range(100000000, 999999999)
			var directory = "C:/Users/jiyan/OneDrive/Desktop/"
			var filename = "ss" + str(random_number) + ".png"
			var path = directory + filename

			if FileAccess.file_exists(path): continue

			screenshot.save_png(path)
			print(filename + " saved!")
			break