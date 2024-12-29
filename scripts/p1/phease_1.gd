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

@export var EncounterText : Array = ["* This is a Undertale template."]
var _EncounterText = null

func _ready():
	chara_anim.play("normal")
	pass

func _process(delta):
	if %PlayerNode.get_select() :
		select_player.visible = true
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
				if Input.is_action_just_pressed("ui_accept"):
					pass
				%BattleButton/UiP1FightNormal.frame = 1
				%BattleButton/UiP1ActNormal.frame = 0
				%BattleButton/UiP1ItemNormal.frame = 0
				%BattleButton/UiP1MercyNormal.frame = 0
				select_player.position.x = 63
				select_player.position.y = 638
			1:
				%BattleButton/UiP1ActNormal.frame = 1
				%BattleButton/UiP1FightNormal.frame = 0
				%BattleButton/UiP1ItemNormal.frame = 0
				%BattleButton/UiP1MercyNormal.frame = 0
				select_player.position.x = 375
				select_player.position.y = 638
			2:
				%BattleButton/UiP1ItemNormal.frame = 1
				%BattleButton/UiP1FightNormal.frame = 0
				%BattleButton/UiP1MercyNormal.frame = 0
				%BattleButton/UiP1ActNormal.frame = 0
				select_player.position.x = 707
				select_player.position.y = 638
			3: 
				%BattleButton/UiP1MercyNormal.frame = 1
				%BattleButton/UiP1ActNormal.frame = 0
				%BattleButton/UiP1FightNormal.frame = 0
				%BattleButton/UiP1ItemNormal.frame = 0
				select_player.position.x = 1003
				select_player.position.y = 638
	else:
		%BattleButton/UiP1MercyNormal.frame = 0
		%BattleButton/UiP1ActNormal.frame = 0
		%BattleButton/UiP1FightNormal.frame = 0
		%BattleButton/UiP1ItemNormal.frame = 0
		%PlayerNode.set_choose(0)
		select_player.visible = false

func set_pane_v():
	pane.visible = false
	
func border_menu_anim():
	bdown_anim.play("menu")
	bup_anim.play("menu")
	bleft_anim.play("menu")
	bright_anim.play("menu")
	player.visible = false
	pass

func border_attick_anim():
	bdown_anim.play("attick")
	bup_anim.play("attick")
	bleft_anim.play("attick")
	bright_anim.play("attick")
	player.visible = true;
	pass


func _on_button_button_down():
	%PlayerNode.set_select(true)
	border_menu_anim()
	pass

func _on_button_2_button_down():
	%PlayerNode.set_select(false)
	border_attick_anim()
	pass 
