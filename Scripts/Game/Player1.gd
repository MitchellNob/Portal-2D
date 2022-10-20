extends KinematicBody2D

#This is the Max walk speed that our character can travel
var Max_Walkspeed = 200
#This is a speed that will change as the character accels towards the Max_Walkspeed
var speed = 0
#This is another variable that will increase the characters max speed if they press shift
var Max_Sprintspeed = 300
#This is the acceleration at which our character will begin to speed up to
var acceleration = 1
#This is the direction that we will be moving in it is (0,0) or .ZERO
var move_direction = Vector2(0,0)

#Here I call upon different Nodes within my scene so that and turn the into a variable
#so I can use them later on
onready var anim_sprite = $AnimationPlayer
onready var EndGun = $Head/Gun/EndGun

#A packed scene is a simplified way of calling for a scene I can go into the inspector
#and assign the scene to the variable
export (PackedScene) var BlueBullet

#The start function can only run as the script is called, the _phyiscs_process function
#is by default run 60 times every second, this means that physics mechanics, such as 
#movement is much smoother
func _physics_process(delta):
#Here we call the movement, animation and aim function as they all need to be 
#processed 
	Movement(delta)
#Animation(delta) 
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

	if Input.is_action_just_pressed("PortalBlue") && Global.BluePortal == true:
		Shoot()

func Shoot():
	Global.BluePortal = false
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
