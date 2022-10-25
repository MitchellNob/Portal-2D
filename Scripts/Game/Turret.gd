extends Node2D

#Here we set the speed at which the turret will rotate to the variable rotationSpeed.
onready var RotationSpeed = 200

#Here we have PackedScene that we export, using export allows the PackedScene to be seen
#in the inspector when you inspect the node the script is attached to. PackedScenes can be
#set to a variable and allows you to store information about a different scene within the 
#variable so you can call it later in the script when you are instancing the scene.
export (PackedScene) var BulletScene

#Here we are calling different nodes within the scene and storing them within these
#variables.
onready var turret = $"."
onready var rayCast = $AnimatedSprite/RayCast2D
onready var Barrel = $Position2D

#We set the variable CanShoot to true, which we will use later to determine if
#turret bullet can be instanced or not.
var CanShoot = true

#In the process function we have an if statement that checks to see if the Global
#variable Paused is equal to false, we do this so if the game is paused than the
#turret can no longer rotate
func _process(delta):
	if Global.Paused == false:
#If the game is not paused than we add our RotationSpeed timesed by the delta to
#the rotation of the turret, this allows the turret to spin in place.
		turret.rotation_degrees += RotationSpeed * delta
#We also call the Shoot() function so that a bullet can be instanced.
		Shoot()


func Shoot():
#First we run an if statement to see if the raycast we have in our scene is 
#colliding with something and if the CanShoot variable is equal to true.
	if rayCast.is_colliding() && CanShoot == true:
#If the raycast is colliding with something than we get what it is colliding with
#and if it is in the group "Player1" we instance a bullet.
		if rayCast.get_collider().is_in_group("Player1"):
#We create a new variable and create the instance within the variable.
			var Bullet = BulletScene.instance()
#We than add this instanced Bullet the parent of the scene
			get_parent().add_child(Bullet)
#We than set the instanced Bullet to the end of the players character
			Bullet.global_position = Barrel.global_position
#We also set the rotation of the bullet to the turrets rotatin however, this
#will set it to the wrong rotation so we need to add an extra 90 degrees
			Bullet.rotation_degrees = turret.rotation_degrees + 90
#We tgeb call on the MoveSetup function from the script that the Bullet scene
#within that we set a value within the function, this value gets the position
#at which the raycast collided with something and then minuses it by the position 
#of the node that this script is attached to.
			Bullet.MoveSetup(rayCast.get_collision_point() - position)
#We then set the CanShoot function to false so that it can no longer shoot and 
#we call the BulletTimer() function
			CanShoot = false
			BulletTimer()

#In this BulletTimer function we create a timer that lasts for 0.5 seconds, after 
#the 0.5 seconds is up we set the CanShoot variable to true.
func BulletTimer():
	yield(get_tree().create_timer(.5), "timeout")
	CanShoot = true
