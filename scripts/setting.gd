extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$Back.connect("pressed",_back)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _back():
	MusicController.button_p()
	get_tree().change_scene_to_file("res://main_menu.tscn")
