extends KinematicBody2D

#This variable stores a Vector2, right now we have it set to 0 as we don't want
#it to move
var velocity = Vector2.ZERO
#This is the speed at which the bullet will travel
export var speed = 700
#This is a boolean variable that we set to tell the script whether we are shooting
#or not
var Shooting = false

#This variable just stores the root node that the script is attached to
#, we use the onready function because we want it to be stored when the script
#is called however we don't have a ready function.
onready var BlueBullet = $"."

#This is a PackedScene that we export to the Inspector so that we can select the
#scene that we wish to use, we than set the selected scene as a variable.
export (PackedScene) var blue_portal

#The start function can only run as the script is called, the _phyiscs_process function
#is by default run 60 times every second, this means that physics mechanics, such as 
#movement is much smoother.
func _physics_process(delta):
# we create a new variable and than within that variable we use the move_and_collide
#function that is built into the game engine, to not only move the bullet but
#detect if it is colliding with something.
	var collision = move_and_collide(velocity.normalized() * delta * speed)
#If it is colliding than we call on the Portal function and the in-built 
#queue_free function to delete the node.
	if collision:
		Portal(delta)
		queue_free()

#In the portal function we Instance the portal scene and we set the Global variables
#BluePortal and BlueShot to true and false respectively, this tells the rest of the
#game that the blue portal is within the scene and that there is no longer a bullet
func Portal(delta):
	var BPortal = blue_portal.instance()
	get_parent().add_child(BPortal)
	BPortal.global_position = BlueBullet.global_position
	Global.BluePortal = true
	Global.BlueShot = false

#Here we use an area2D node again and connect it to this script, so that if it 
#enters another area (in this case the orange portal and walls that portals can't
#be on), then it destroys the object and sets the Global variable BlueShot to true
func _on_Area2D_area_entered(area):
	if area.is_in_group("OrangePortal"):
		queue_free()
		Global.BlueShot = false
	if area.is_in_group("DeadWall"):
		queue_free()
		Global.BlueShot = false
