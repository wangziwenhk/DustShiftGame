extends Control

@onready var _menu_player: AudioStreamPlayer = $MainMenuMusic
@onready var _button_p: AudioStreamPlayer = $ButtonP
@onready var _save: AudioStreamPlayer = $Saved
@onready var _ut_start: AudioStreamPlayer = $UTStart
@onready var _text: AudioStreamPlayer = $Text
@onready var _damage: AudioStreamPlayer = $damage
@onready var _spearappear: AudioStreamPlayer = $spearappear
@onready var _av_audio: AudioStreamPlayer = $AVAudio
@onready var _select: AudioStreamPlayer = $Select

var _menu_status: bool = true

func play_select():
	_select.play()

func play_av():
	_av_audio.play()
	
func stop_av():
	_av_audio.stop()

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
