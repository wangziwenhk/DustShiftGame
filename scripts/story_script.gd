extends Control

@onready var tween = get_tree().create_tween()
var thread: Thread

var text_array = [
	"DEBUG TEXT",
	"DEBUG TEXT",
	"DEBUG TEXT"
]

var text_index = 0
var text_start = false
var text_status = false

func start_text():
	read_text()
	text_start = true
	
func end_text():
	text_index = 0
	$RichTextLabel.visible_ratio = 0
	text_start = false
	
	
func _ready():
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN_OUT)
	start_text()
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and text_start and (!text_status):
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
		tween.tween_property($RichTextLabel,"visible_ratio",1,3)
		tween.play()
	else:
		end_text()
		return
	text_index += 1
	
func _frame_update(msg):
	thread = Thread.new()
	thread.start(_thread_function.bind(msg))

func _thread_function(msg):
	for i in msg:
		MusicController.text_audio()
		OS.delay_msec(95)
	text_status = false
