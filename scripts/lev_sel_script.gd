extends Node2D

@onready var back: TextureButton = $Back
@onready var sp1: TextureButton = $SP1
@onready var sp2: TextureButton = $SP2
@onready var sp3: TextureButton = $SP3
@onready var new_node: ColorRect = $StartPane

@onready var psel_left_anim: AnimationPlayer = $PselLeft/AnimationPlayer
@onready var psel_right_anim: AnimationPlayer = $PselRight/AnimationPlayer

var phease: int = 0
var start: int  = 0
var thread      = Thread.new()

func _ready():
	back.connect("pressed",_back)
	sp1.connect("pressed",_sp1)
	sp2.connect("pressed",_sp2)
	sp3.connect("pressed",_sp3)
	sp1.connect("hovered",_sp1_hover)
	$P1S/P1SAnimation.connect("animation_finished",_animation_finished_sp1)
	$P2S/P2SAnimation.connect("animation_finished",_animation_finished_sp2)
	psel_left_anim.play("start")
	psel_right_anim.play("start")

func _process(_delta) -> void:
	if start == 1 && new_node.color.a < 1:
		new_node.color.a += 0.003
		return
	
	if start == 2:
		get_tree().change_scene_to_file("res://phease_1.tscn")
		return
	
	if get_node("SP1").is_hovered():
		_sp1_hover()
	elif get_node("SP2").is_hovered():
		_sp2_hover()
	elif get_node("SP3").is_hovered():
		_sp3_hover()
	pass
	
func _sp1_hover() -> void:
	if phease == 1: return
	phease = 1
	$P3S/P3SAnimation.play("RESET")
	$P2S/P2SAnimation.play("RESET")
	$P1S/P1SAnimation.play("in_move")
	
	
func _sp2_hover() -> void:
	if phease == 2: return
	phease = 2
	$P3S/P3SAnimation.play("RESET")
	$P1S/P1SAnimation.play("RESET")
	$P2S/P2SAnimation.play("in_move")

func _sp3_hover() -> void:
	if phease == 3: return
	phease = 3
	$P1S/P1SAnimation.play("RESET")
	$P2S/P2SAnimation.play("RESET")
	$P3S/P3SAnimation.play("in_move")
	
func _animation_finished_sp1(name):
	if name == "in_move":
		pass
		#$P2S/P2SAnimation.play("out_move")
	
func _animation_finished_sp2(name):
	if name == "in_move":
		pass
		#$P1S/P1SAnimation.play("out_move")
	
func _sp1():
	MusicController.save()
	MusicController.stop_main_menu()
	MusicController.ut_start()
	new_node.color.a = 0
	new_node.move_to_front()
	start = 1
	thread.start(_thread_function)
	pass
	
func _sp2():
	MusicController.save()
	MusicController.stop_main_menu()
	get_tree().change_scene_to_file("res://phease_2.tscn")
	pass
	
func _sp3():
	MusicController.save()
	pass

func _back():
	MusicController.button_p()
	get_tree().change_scene_to_file("res://main_menu.tscn")
	
func _thread_function():
	OS.delay_msec(1000 * 6)
	start = 2
	pass
