extends ButtonControl

@onready var world := get_tree().root.get_node("World3D") as World
@onready var player := world.get_node("Player") as BaseCharacter

func _on_texture_button_button_up():
	super()
	

