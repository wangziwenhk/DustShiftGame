extends Node

@onready var animation = $Title/AnimationPlayer
@onready var animation_subtitle = $Subtitle/AnimationPlayer
@onready var animation_warn_info = $WarnInfo/AnimationPlayer
@onready var ok_z  = $Label/AnimationPlayer
@onready var menu = load("res://main_menu.tscn")

var status = true

func _ready():
	animation.connect("animation_finished",_show_subtitle)
	animation_warn_info.connect("animation_finished",_show_warn)
	animation_subtitle.connect("animation_finished",_subtitle_done)
	MusicController.play_spearappear()
	animation.play("start")

func _show_subtitle(name):
	if name == "start":
		await wait_for_sec(0.1)
		animation_subtitle.play("fadeIn")
	elif name == "fadeOn":
		await wait_for_sec(1.0)
		animation_warn_info.play("fadeIn")

func _process(delta):
	if (!status) and (Input.is_action_just_pressed("ui_true")):
		status = true
		ok_z.stop()
		animation.play("fadeOn")
		animation_subtitle.play("fadeOn")

func _show_warn(name):
	if name == "fadeIn":
		_wait()
	elif name == "wait":
		await wait_for_sec(0.1)
		animation_warn_info.play("fadeOn")
	elif name == "fadeOn":
		await wait_for_sec(1.0)
		_change_scene()

func _subtitle_done(name):
	if name == "fadeIn":
		status = false
		ok_z.play("loop")
	pass

func _wait():
	animation_warn_info.play("wait")

func _change_scene():
	get_tree().change_scene_to_packed(menu)
	
func wait_for_sec(sec : float) -> void:
	await get_tree().create_timer(sec).timeout
