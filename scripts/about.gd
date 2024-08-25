extends Control

@onready var back = $Back
@onready var vsl = $VScrollBar
@onready var info = $AboutInfo

func _ready():
	back.connect("pressed",_back)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	info.position.y = (-vsl.value) + 1857.5
	pass

func _back():
	MusicController.button_p()
	get_tree().change_scene_to_file("res://main_menu.tscn")
