extends KinematicBody2D

var Max_Walkspeed = 200
var speed = 0
var Max_Sprintspeed = 300
var acceleration = 1
var move_direction = Vector2(0,0)

onready var anim_sprite = $AnimatedSprite


func _physics_process(delta):
	Movement(delta)
	Animation()

func Movement(delta):
	move_direction.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	move_direction.y = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))
	if move_direction == Vector2(0,0):
		speed = 0
	else:
		speed += acceleration * delta
		if  int(Input.is_action_pressed("Sprint")):
			speed = Max_Sprintspeed
		else:
			speed = Max_Walkspeed
			if speed > Max_Walkspeed:
				speed = Max_Walkspeed

		var motion = move_direction.normalized() * speed
		move_and_slide(motion)

func Animation():
	print_debug("HEllo")
	match move_direction:
		Vector2(-1, 0):
			print_debug("Work")
			anim_sprite = "Left"
		Vector2(1, 0):
			anim_sprite = "Right"
		Vector2(-1, -0.5):
			anim_sprite = "Left"
		Vector2(-1, 0.5):
			anim_sprite = "Left"
		Vector2(1, -0.5):
			anim_sprite = "Right"
		Vector2(-1, -0.5):
			anim_sprite = "Right"

	if move_direction == Vector2(0, 0):
		anim_sprite = "Idle"
