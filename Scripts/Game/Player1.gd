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
#This variable determines if the character can teleport
var CanTeloport = true
#Here I call upon different Nodes within my scene so that and turn the into a variable
#so I can use them later on
onready var anim_sprite = $AnimationPlayer
onready var EndGun = $Head/EndGun

#A packed scene is a simplified way of calling for a scene I can go into the inspector
#and assign the scene to the variable
export (PackedScene) var BlueBullet
export (PackedScene) var OrangeBullet
export (PackedScene) var BPortal
export (PackedScene) var OPortal

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
#move_direction is the vector we set before, here we are assigning the x axis of the vector by 
#getting the number or integer input depending on the movement button we press
	move_direction.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
#this is just doing the same thing however for the y axis
	move_direction.y = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))
#here we are using an if statement that says if the move_direction = .ZERO or the character is 
#no movement keys being inputed than we set the speed to 0 so that the character doesn't continue to move
	if move_direction == Vector2(0,0):
		speed = 0
#We than use an else statement for anytime that the above if statement is false, here if the
#vector2 > 0 than we are timesing the speed by the acceleration * delta, the delta is part
#of the _physics_process, this allows the movement to not depend on frame rate and instead 
#will update 60 times a second, with varying frame rates something that relies on frames
#can fluctuate so it is better to use delta
	else:
		speed += acceleration * delta
#here we have another if statement that states that if the shift key is press than the speed is
#equal to the variable Max_sprintspeed instead of the speed
		if  int(Input.is_action_pressed("Sprint")):
			speed = Max_Sprintspeed
#Than we have an else statement (so if the shift key is not being pressed), we change the speed 
#back to the Max_Walkspeed and if it is larger than the max
		else:
			speed = Max_Walkspeed
#Here we are setting a new variable called motion, motion variable stores the move_direction
#and then the move_direction is normalized(). normalized() means that the vector is only set
#to a length of 1, not doing this means that if we wanted to go diagonal, we would go faster
#we than also times this by the speed in order for us to be able to move
	var motion = move_direction.normalized() * speed
#the move_and_slide() function allows kinematic_bodies to stop when a collision occurs, the
#move and slide function directly influences our motion variable
	move_and_slide(motion)

func Aim(delta):
	#this is an inbuilt function within godot, first we get the node that we want to rotate
	#which in this case is the Head, than we simply state the look_at() function, within 
	#this function we have another function that records the position of the mouse, with 
	#these two functions the Head will now look to where to mouse is on the screen
	$Head.look_at(get_global_mouse_position())

#here we have an if statement that waits for the left mouse button to be pressed
#however using && we set another paremeter that needs to be met before this if
#statement can work, our global variable BluePortal has to be equal to true
	if Input.is_action_just_pressed("BluePortal") && Global.BluePortal == true && Global.BlueShot == false:
#if the if the statement parameters are met than call upon the Shoot() function
		ShootBlue()
		Global.BlueShot = true
	if Input.is_action_just_pressed("OrangePortal") && Global.OrangePortal == true && Global.OrangeShot == false:
		ShootOrange()
		Global.OrangeShot = true

func ShootBlue():
#We create a new variable and call upon the packed scene variable we created earlier,
#the instance function that we use allows us to instantiate the BlueBullet scene into
#the current scene, basically copying all of the configuration from the BlueBullet
#scene  
	var blue_instance = BlueBullet.instance()
#We than add the child as a child of our root node for the scene
	get_parent().add_child(blue_instance)
#We want the bullet to spawn at the tip of the gun so we get the EndGun variable
#that is linked to a transform2D and we set it so that the BlueBullet scene is 
#instantiated at the transfrom2D position
	blue_instance.global_position = EndGun.global_position

#we than give the bullet velocity towards the global mouse positin, however if we
#don't minus the blue_instances position from the global_mouse_position than the
#bullet will go in the wrong direction
	blue_instance.velocity = get_global_mouse_position() - blue_instance.position

func ShootOrange():
	#Here we are doing the same thing as the ShootBlue function however for the
	#orange portal
	var orange_instance = OrangeBullet.instance()
	get_parent().add_child(orange_instance)
	orange_instance.global_position = EndGun.global_position
	
	orange_instance.velocity = get_global_mouse_position() - orange_instance.position

func _on_Area2D_area_entered(area):
	if CanTeloport && area.is_in_group("BluePortal"):
		TeleportToOrange()
		CanTeloport = false
		yield(get_tree().create_timer(.5), "timeout")
		CanTeloport = true

	if CanTeloport && area.is_in_group("OrangePortal"):
		TeleportToBlue()
		CanTeloport = false
		yield(get_tree().create_timer(.5), "timeout")
		CanTeloport = true
	
	if area.is_in_group("Poison"):
		Kill()

func TeleportToOrange():
	for OPortal in get_tree().get_nodes_in_group("OrangePortal"):
		global_position = OPortal.global_position
	
#	var ExitSpeed = max(abs(move_direction.x), abs(move_direction.y))
#	move_direction = Vector2()
	#var dir = OrangePortal.point.glob_position - OrangePortal.global_position
	#apply_central_impulse(dir * ExitSpeed)

func TeleportToBlue():
	for BPortal in get_tree().get_nodes_in_group("BluePortal"):
		global_position = BPortal.global_position
	
	yield(get_tree().create_timer(.1), "timeout")
	
	var ExitSpeed = max(abs(move_direction.x), abs(move_direction.y))
	move_direction = Vector2()
	#var dir = OrangePortal.point.glob_position - OrangePortal.global_position
	#apply_central_impulse(dir * ExitSpeed)

func Kill():
	queue_free()

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
