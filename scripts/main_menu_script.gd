extends Node

@onready var start: TextureButton = $StartButton
@onready var about: TextureButton = $AboutButton

@onready var start_pane: ColorRect = $StartPane
@onready var title: Sprite2D = $Title
@onready var subtitle: Sprite2D = $Subtitle

func _ready():
	start.connect("pressed",on_start_button)
	about.connect("pressed",on_about_button)
	start.modulate.a = 0
	about.modulate.a = 0
	title.modulate.a = 0;
	subtitle.modulate.a = 0;
	start_pane.modulate.a = 1
	MusicController.play_main_menu()

func _process(_delta):
	if(title.modulate.a < 1):
		title.modulate.a += 0.01
		subtitle.modulate.a += 0.01
	elif(start_pane.modulate.a > 0&&title.modulate.a >= 1):
		start_pane.modulate.a -= 0.01
		start.modulate.a += 0.01
		about.modulate.a += 0.01

# 
func on_about_button():
	MusicController.button_p()
	get_tree().change_scene_to_file("res://about.tscn")

func on_start_button():
	MusicController.button_p()
	get_tree().change_scene_to_file("res://lev_sel.tscn")
	
