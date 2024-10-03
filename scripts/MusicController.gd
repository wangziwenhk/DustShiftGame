extends Control

@onready var _menu_player = $MainMenuMusic
@onready var _button_p = $ButtonP
@onready var _save = $Saved
@onready var _ut_start = $UTStart
@onready var _text = $Text
@onready var _damage = $damage
@onready var _spearappear = $spearappear

var _menu_status = true

func play_damage():
	_damage.play()
	
func play_spearappear():
	_spearappear.play()

func play_main_menu():
	if(_menu_status):
		_menu_player.play()
		_menu_status = false

func stop_main_menu():
	_menu_player.stop()
	_menu_status = true
	
func button_p():
	_button_p.play()
	
func save():
	_save.play()

func ut_start():
	_ut_start.play()

func text_audio():
	_text.play()
