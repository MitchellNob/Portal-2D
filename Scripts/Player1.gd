extends KinematicBody2D

var Max_Walkspeed = 200
var speed = 0
var Max_Sprintspeed = 300
var acceleration = 1
var move_direction = Vector2(0,0)

var anim_direction = "W"
var anim_mode = "idle"
var animation

func _physics_process(delta):
	 Movement(delta)

func _process(delta):
	Animation()

func Movement(delta):
	rotation = 
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
	match move_direction:
		Vector2(-1, 0):
			anim_direction = "A"
		Vector2(1, 0):
			anim_direction = "D"
		Vector2(0, 0.5):
			anim_direction = "S"
		Vector2(0, -0.5):
			anim_direction = "W"
		Vector2(-1, -0.5):
			anim_direction = "WA"
		Vector2(-1, 0.5):
			anim_direction = "SA"
		Vector2(1, -0.5):
			anim_direction = "WD"
		Vector2(-1, -0.5):
			anim_direction = "SD"

	if move_direction != Vector2(0, 0):
		anim_mode = "Walk"
	else:
		anim_mode = "Idle"
	animation = anim_mode + "_" + anim_direction
	get_node("AnimationPlayer").play(animation)
