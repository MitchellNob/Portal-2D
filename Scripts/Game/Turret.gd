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

			var Bullet = BulletScene.instance()
			get_parent().add_child(Bullet)
			Bullet.global_position = Barrel.global_position
			Bullet.rotation_degrees = turret.rotation_degrees + 90
			Bullet.MoveSetup(rayCast.get_collision_point() - position)
			CanShoot = false
			BulletTimer()


func BulletTimer():
	yield(get_tree().create_timer(.5), "timeout")
	CanShoot = true
