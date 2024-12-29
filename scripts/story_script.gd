extends Control

@onready var rect = $ColorRect2/AnimationPlayer
var thread: Thread

@export var EncounterText : Array = ["* This is a Undertale template."]

var _EncounterText = null

@export var text_array : Array = [
	"☜︎☠︎❄︎☼︎✡︎ 💧︎☜︎❄︎ ☞︎✋︎☠︎✌︎☹︎📬︎ ❄︎✋︎💣︎☜︎☹︎✋︎☠︎☜︎ ☜︎☠︎👎︎📬︎",
	"❄☟☜ ❄🕈⚐ ☟🕆💣✌☠💧 👌⚐❄☟ 💧❄✌☼❄☜👎 😐✋☹☹✋☠☝\n📪 💣✡ ☹✌💧❄ ☜✠🏱☜☼✋💣☜☠❄ 👍⚐🕆☹👎 ☞✋☠✌☹☹✡ 👌☜☝✋☠📬",
	"Hundreds of timelines had passed and all ended up with genocide.",
	"To be able to beat the human’s strong DETERMINATION, Chara had \nto gain the ultimate power of LOVE.",
	"She broke her own moral and started killing to compete with the human.",
	"But even after she had erased half of the monsterkind...",
	"That power... wasn’t enough.",
	"The human just kept winning and resetting all the time, \nwithout measuring the cost...",
	"And now something changed.",
	"In one timeline, Chara was wandering in the Waterfall \nand she found a small door.",
	"Seeking for her new victims, she opened it and got in.",
	"That room only remained some fragmentary flowers...",
	"But staring at them, Chara started to remember.",
	"All the past... all the genocides... all the attempts.",
	"The flower-shaped mysterious figured said they would \nhelp Chara to beat the human...",
	"With a lost EXPERIMENT. A secret weapon, and now the \nlast hope of the winning of the monsters.",
	"Now, with the new preparation...",
	"Chara would make sure this is the last liquidation."
]

var text_index = 0
var text_start = false
var text_status = false

var config = ConfigFile.new()
var text_length = 0

func end_text():
	text_index = 0
	$RichTextLabel.visible_ratio = 0
	text_start = false
	var err = config.load("user://player_data.cfg")
	config.set_value("","story","true")
	config.save("user://player_data.cfg")
	
func _ready():
	MusicController.play_av()
	_text()
	pass

func _process(delta):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_true")):
		if _EncounterText:
			if _EncounterText.is_end():
				reset_text()
		_text()

func _text():
	if text_start: 
		return
	if text_index >= text_array.size():
		MusicController.stop_av()
		MusicController.ut_start()
		rect.play("fadeOut")
		text_start = true
	if not _EncounterText :
		var text = preload("res://text/text.tscn")
		_EncounterText = text.instantiate()
		EncounterText[0] = text_array[text_index]
		_EncounterText.text = EncounterText
		_EncounterText.position = Vector2(55, 575)
		add_child(_EncounterText)
	else:
		_EncounterText.modulate.a = 1
		if text_index >= text_array.size():
			EncounterText[0] = text_array[text_array.size() - 1]
		else:
			EncounterText[0] = text_array[text_index]
		_EncounterText.text = EncounterText

func reset_text():
	if text_start: 
		return
	if _EncounterText :
		_EncounterText.modulate.a = 0
		_EncounterText.label.visible_characters = 0 #_EncounterText._text[_EncounterText.page].length()
		_EncounterText.text = ""
		text_index += 1

func _on_animation_player_animation_finished(anim_name):
	if anim_name=="fadeOut":
		get_tree().change_scene_to_file("res://phease_1.tscn")
