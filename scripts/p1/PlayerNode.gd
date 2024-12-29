extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
static var is_selct = false
static var choose = 0

func get_choose():
	return choose
	
func set_choose(v : int):
	choose = v

func get_select():
	return is_selct

func set_select(v : bool):
	is_selct = v

func _physics_process(delta):
	if !is_selct:
		var direction0 = Input.get_axis("ui_up", "ui_down")
		if direction0:
			velocity.y = direction0 * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
	else:
		pass
	
