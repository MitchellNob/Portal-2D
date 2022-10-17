extends KinematicBody2D

var Max_Walkspeed = 200
var speed = 0
var Max_Sprintspeed = 300
var acceleration = 1
var move_direction = Vector2(0,0)
var NoShoot = false

onready var anim_sprite = $AnimationPlayer
onready var EndGun = $Head/Gun/EndGun

export (PackedScene) var BlueBullet

func _physics_process(delta):
	Movement(delta)
#	Animation(delta) 

func _process(delta):
	Aim(delta)

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

func Aim(delta):
	$Head.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("PortalBlue"):
		Shoot()

func Shoot():
		if  Global.Shoot == false:
			Global.Shoot = true
			var blue_instance = BlueBullet.instance()
			get_parent().add_child(blue_instance)
			blue_instance.global_position = EndGun.global_position
	
			blue_instance.velocity = get_global_mouse_position() - blue_instance.position

##func Animation(delta):
#	match move_direction:
#		Vector2( -1, 0 )
#			print_debug("Left")
#			anim_sprite.animation = "Left"
#		Vector2( 1, 0 )
#			print_debug("Right")
#			anim_sprite.animation = "Right"
#		Vector2( -1, -0.5 )
#			print_debug("Left")
#			anim_sprite.animation = "Left"
#		Vector2( -1, 0.5 )
#			print_debug("Left")
#			anim_sprite.animation = "Left"
#		Vector2( 1, -0.5 )
#			print_debug("Right")
#			anim_sprite.animation = "Right"
#		Vector2( -1, -0.5 )
#			print_debug("Right")
#			anim_sprite.animation = "Right"
#		Vector2( 0, 1 )
#			print_debug("walkdown")
#			anim_sprite.animation = "WalkUp"
#		Vector2( 0, -1 )
#			print_debug("walkup")
#			anim_sprite.animation = "WalkUp"
#		Vector2( 0, 0 )
#			print_debug("Idle")
#		s	anim_sprite.animation = "Idle"
