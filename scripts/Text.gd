extends Node2D

@onready var label = $RichTextLabel
@onready var bubble = $bubble

var text = [""]
var _text = [""]
var length = 0
var speed = 1
var timer = 0

var text_spacing = 0
var text_size = 24
var normal_font = FontVariation.new()

var met_hod_index = 0
var teshu_things = ""
var teshu_index_list = []
var teshu_things_list = []
var open_read = false
var now_do = ""
var can_shu_math = 0

var wait_time = 0
var can_skip = true
var can_sc = false
var can_endd = false
var page = 0
var pause = false
var np = false
var end = false
var bubbles = false

var nextX = 1

func extract(index):
	var csm = 0
	csm = now_do.right(index - 2)
	csm = (csm.left(-1))
	return csm

func _ready():
	z_index = 600
	$RichTextLabel.visible_characters = 0
	_text = text
	if bubbles :
		label.modulate = Color(0, 0, 0)
		text_size = 18
	if $RichTextLabel.visible_characters <= length and not pause and wait_time <= 0:
		for i in teshu_index_list:
			if i == $RichTextLabel.visible_characters:
				var number_js=0
				if not pause and wait_time <= 0 :
					for j in range(0,teshu_index_list.count(i)):
						number_js=number_js+1
						now_do = teshu_things_list[teshu_index_list.find(i)+j]
						if now_do.find("w") != -1 :
							can_shu_math = float(extract(-1))
							wait_time = can_shu_math
						if now_do.find("color") != -1 :
							can_shu_math = extract(-5)
							match can_shu_math :
								"white":
									$RichTextLabel.modulate = Color(1,1,1)
								"red":
									$RichTextLabel.modulate = Color(1,0,0)
								"yellow":
									$RichTextLabel.modulate = Color(1,1,0)
								"green":
									$RichTextLabel.modulate = Color(0,1,0)
						if now_do.find("noskip") != -1 :
							can_skip = false
						if now_do.find("can_next") != -1:
							can_sc = true
						if now_do.find("can_end") != -1:
							can_endd = true
						if now_do.find("speed") != -1:
							speed = int(extract(-5))
						#CommandLabel()
						
						if teshu_index_list.count(i)>=2 and teshu_index_list.count(i)==number_js:
							break
	

func _process(delta):
	
	for i in _text[page] :
		if i == "[" :
			open_read = true
			teshu_index_list.append(met_hod_index)
		elif i == "]":
			open_read = false
			teshu_things += i
			teshu_things_list.append(teshu_things)
			teshu_things = ""
			_text[page] = _text[page].erase(met_hod_index,1)
			met_hod_index -= 1
		if open_read:
			
			teshu_things += i
			_text[page] = _text[page].erase(met_hod_index,1)
			met_hod_index -= 1
		met_hod_index += 1
	$RichTextLabel.text = _text[page]
	
	
	normal_font.set_base_font(load("res://fonts/font_text.ttf"))
	$RichTextLabel.add_theme_font_override("normal_font",normal_font)
	$RichTextLabel.add_theme_font_size_override("normal_font_size",text_size)
	normal_font.set_spacing(TextServer.SPACING_GLYPH,text_spacing)
	length = $RichTextLabel.text.length()

	
	if Input.is_action_just_pressed("back") and can_skip:
		nextX = length
	
	if np and not pause and wait_time <= 0:
		np = false
		page += 1
		nextX = 1
		met_hod_index = 0
		for i in teshu_index_list.size():
			teshu_index_list.remove_at(i)
		for i in teshu_things_list.size():
			teshu_things_list.remove_at(i)
		$RichTextLabel.visible_characters = 0
	
	if end and not pause and wait_time <= 0:
		end = false
		queue_free()
	
	if bubbles :
		bubble.modulate.a = 1
	else:
		bubble.modulate.a = 0
	
	if Input.is_action_just_pressed("confirm") and can_sc and $RichTextLabel.visible_characters >= length :
		if page >= text.size() - 1 :
			if $RichTextLabel.visible_characters >= length :
				queue_free()
		else:
			nextX = 1
			page += 1
			met_hod_index = 0
			for i in teshu_index_list.size():
				teshu_index_list.remove_at(i)
			for i in teshu_things_list.size():
				teshu_things_list.remove_at(i)
			$RichTextLabel.visible_characters = 0
	
	
	if pause and Input.is_action_just_pressed("confirm") :
		pause = false
	
	for sleep in nextX :
		for v in nextX :
			if not pause :
				if wait_time > 0 :
					wait_time -= 1
				else:
					now_do = ""
					if $RichTextLabel.visible_characters < length:
						if timer == speed :
							if $RichTextLabel.text[$RichTextLabel.visible_characters] != " " :
								MusicController.text_audio()
							else:
								$RichTextLabel.visible_characters += 1
							$RichTextLabel.visible_characters += 1
							timer = 0
						else:
							timer += 1
						##########
					if $RichTextLabel.visible_characters <= length and not pause and wait_time <= 0:
						for i in teshu_index_list:
							if i == $RichTextLabel.visible_characters:
								var number_js=0
								if not pause and wait_time <= 0 :
									for j in range(0,teshu_index_list.count(i)):
										number_js=number_js+1
										now_do = teshu_things_list[teshu_index_list.find(i)+j]
										if now_do.find("w") != -1 :
											can_shu_math = float(extract(-1))
											wait_time = can_shu_math
										if now_do.find("color") != -1 :
											can_shu_math = extract(-5)
											match can_shu_math :
												"white":
													$RichTextLabel.modulate = Color(1,1,1)
												"red":
													$RichTextLabel.modulate = Color(1,0,0)
												"yellow":
													$RichTextLabel.modulate = Color(1,1,0)
												"green":
													$RichTextLabel.modulate = Color(0,1,0)
										if now_do.find("noskip") != -1 :
											can_skip = false
										if now_do.find("can_next") != -1:
											can_sc = true
										if now_do.find("can_end") != -1:
											can_endd = true
										if now_do.find("speed") != -1:
											speed = int(extract(-5))
										#CommandLabel()
									
										if teshu_index_list.count(i)>=2 and teshu_index_list.count(i)==number_js:
											break
