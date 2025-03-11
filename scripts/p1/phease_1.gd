extends Node2D

@onready var chara_anim = $Chara/AnimationPlayer

@onready var bdown_anim = $BDOWN/AnimationPlayer
@onready var bup_anim = $BUP/AnimationPlayer
@onready var bleft_anim = $BLEFT/AnimationPlayer
@onready var bright_anim = $BRIGHT/AnimationPlayer
@onready var pane = $RectHead
@onready var player = $PlayerNode
@onready var select_player = %BattleButton/Select
@onready var b_button = %BattleButton

@export var text_array : Array = [
	"* Chara",
	"* Chara LV19    ATK ??? DEF ???"
]
@export var EncounterText : Array = ["* This is a Undertale template."]
var _EncounterText = null
var text_index = 0
var in_sel = false
var in_fight = false

func _ready():
	chara_anim.play("normal")

func _process(delta):
	accept_sel()
	select()
	
func accept_sel():
	if %PlayerNode.get_select() :
		match %PlayerNode.get_choose():
			0:
				if in_fight:
					if Input.is_action_just_pressed("ui_true"):
						pass
				else:
					if Input.is_action_just_pressed("ui_true"):
						in_fight = true
			1:
				if Input.is_action_just_pressed("ui_true"):
					if in_sel:
						in_sel = false
						reset_text()
						_on_button_2_button_down()
					else:
						text_index = 1
						_text()
						in_sel = true
			2:
				pass
			3:
				if Input.is_action_just_pressed("ui_true"):
					MusicController.play_test()

func select():
	if %PlayerNode.get_select():
		select_player.visible = true
		
		if (not in_sel) and (not in_fight):
			if %PlayerNode.get_choose() > 3:
				%PlayerNode.set_choose(0)
			elif %PlayerNode.get_choose() < 0:
				%PlayerNode.set_choose(3)
		
			if Input.is_action_just_pressed("ui_left"):
				MusicController.play_select()
				%PlayerNode.set_choose(%PlayerNode.get_choose() - 1)
			elif Input.is_action_just_pressed("ui_right"):
				MusicController.play_select()
				%PlayerNode.set_choose(%PlayerNode.get_choose() + 1)
		
			match %PlayerNode.get_choose():
				0:
					set_frame(1,0,0,0)
					select_player.position.x = 63
					select_player.position.y = 638
				1:
					set_frame(0,1,0,0)
					select_player.position.x = 375
					select_player.position.y = 638
				2:
					set_frame(0,0,1,0)
					select_player.position.x = 707
					select_player.position.y = 638
				3: 
					set_frame(0,0,0,1)
					select_player.position.x = 1003
					select_player.position.y = 638
	else:
		set_frame(0,0,0,0)
		%PlayerNode.set_choose(0)
		select_player.visible = false

func set_pane_v():
	pane.visible = false

func set_frame(fight,act,item,mercy):
	%BattleButton/UiP1MercyNormal.frame = mercy
	%BattleButton/UiP1ActNormal.frame = act
	%BattleButton/UiP1FightNormal.frame = fight
	%BattleButton/UiP1ItemNormal.frame = item

func border_menu_anim(p : bool):
	bdown_anim.play("menu")
	bup_anim.play("menu")
	bleft_anim.play("menu")
	bright_anim.play("menu")
	if p : player.visible = false
	pass

func border_attick_anim(p:bool):
	bdown_anim.play("attick")
	bup_anim.play("attick")
	bleft_anim.play("attick")
	bright_anim.play("attick")
	if p : player.visible = true;

func _text():
	if not _EncounterText :
		var text = preload("res://text/text.tscn")
		_EncounterText = text.instantiate()
		EncounterText[0] = text_array[text_index]
		_EncounterText.text = EncounterText
		_EncounterText.position = Vector2(150, 320)
		add_child(_EncounterText)
	else:
		_EncounterText.modulate.a = 1
		EncounterText[0] = text_array[text_index]
		_EncounterText.text = EncounterText

func reset_text():
	if _EncounterText :
		_EncounterText.modulate.a = 0
		_EncounterText.label.visible_characters = 0 #_EncounterText._text[_EncounterText.page].length()
		_EncounterText.text = ""
		_EncounterText = null

func _on_button_button_down():
	%PlayerNode.set_select(true)
	border_menu_anim(true)
	pass

func _on_button_2_button_down():
	%PlayerNode.set_select(false)
	border_attick_anim(true)
	pass 
