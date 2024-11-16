extends Control

@onready var tween = get_tree().create_tween()
var thread: Thread

var text_array = [
	"☜︎☠︎❄︎☼︎✡︎ 💧︎☜︎❄︎ ☞︎✋︎☠︎✌︎☹︎📬︎ ❄︎✋︎💣︎☜︎☹︎✋︎☠︎☜︎ ☜︎☠︎👎︎📬︎",
	"❄☟☜ ❄🕈⚐ ☟🕆💣✌☠💧 👌⚐❄☟ 💧❄✌☼❄☜👎 😐✋☹☹✋☠☝📪 💣✡ ☹✌💧❄ ☜✠🏱☜☼✋💣☜☠❄ 👍⚐🕆☹👎 ☞✋☠✌☹☹✡ 👌☜☝✋☠📬",
	"Hundreds of timelines had passed and all ended up with genocide.",
	"To be able to beat the human’s strong DETERMINATION, Chara had to gain the ultimate power of LOVE.",
	"She broke her own moral and started killing to compete with the human.",
	"But even after she had erased half of the monsterkind…",
	"That power… wasn’t enough.",
	"The human just kept winning and resetting all the time, without measuring the cost…",
	"And now something changed.",
	"In one timeline, Chara was wandering in the Waterfall and she found a small door.",
	"Seeking for her new victims, she opened it and got in.",
	"That room only remained some fragmentary flowers…",
	"But staring at them, Chara started to remember.",
	"All the past… all the genocides… all the attempts.",
	"The flower-shaped mysterious figured said they would help Chara to beat the human…",
	"With a lost EXPERIMENT. A secret weapon, and now the last hope of the winning of the monsters.",
	"Now, with the new preparation…",
	"Chara would make sure this is the last liquidation."
]

var text_index = 0
var text_start = false
var text_status = false

var config = ConfigFile.new()

func start_text():
	read_text()
	text_start = true
	
func end_text():
	text_index = 0
	$RichTextLabel.visible_ratio = 0
	text_start = false
	var err = config.load("user://player_data.cfg")
	config.set_value("","story","true")
	config.save("user://player_data.cfg")
	
func _ready():
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN_OUT)
	start_text()
	MusicController.play_av()
	pass

func _process(delta):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_true")) and text_start and (!text_status):
		read_text()

func read_text():
	if text_index < text_array.size():
		text_status = true
		$RichTextLabel.bbcode_text = text_array[text_index]
		if(!tween.is_valid()):
			tween = get_tree().create_tween()
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.set_ease(Tween.EASE_IN_OUT)
			
		$RichTextLabel.visible_ratio = 0
		tween.tween_callback(_frame_update.bind(text_array[text_index]))
		tween.tween_property($RichTextLabel,"visible_ratio",1,2)
		tween.play()
	else:
		end_text()
		return
	text_index += 1
	
func _frame_update(msg):
	thread = Thread.new()
	thread.start(_thread_function.bind(msg))

func _thread_function(msg):
	text_status = false
