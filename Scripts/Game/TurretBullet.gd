extends KinematicBody2D

#Here we are creating a const variable, a constant variable simply means that it cannot be altered
#be modified once is has been set.
const MOVE = Vector2.RIGHT

#Here we export an integer variable, an integer variable means that it stores a whole number, here
#we are setting the speed of the bullet so that we can call it later.
export(int) var Speed = 200

#We also call upon the Timer node within our scene and set it as a variable, so that we can use it
#tomorrow.
onready var timer = $Timer

func _ready():
#When the script is loaded we use the timers in-built system to start the timer,
	timer.start()

func _physics_process(delta):
#Here we have a simple script that creates a variable that stores value that the bullet needs to move
#this value is calcuted by the Vector2.RIGHT, which can also be written as Vector2(1,0), it then 
#rotates it deending on the rotation of the turret. It then timeses this by the Speed variable
#we set earlier and the inbuilt delta variable to create smooth bullet movement.
	var movement = MOVE.rotated(rotation) * Speed * delta
#We then add the movement value we just calculated to the global_position of the bullet so that the
#bullet actually moves.
	global_position += movement

#If the another Area2D enters the bullets Area2D it runs a signal function, within this signal function
#if th other Area2D is equal to Player1, then we minus 20 health from the player so they take damage. 
#We also destroy the bullet scene with the in-built function queue_free
func _on_Area2D_area_entered(area):
	if area.is_in_group("Player1"):
		Global.Health -= 20
		queue_free()

#Once the timer that we told to start in the ready function has run out, we destroy the bullet scene
#with the in-built function queue_free
func _on_Timer_timeout():
	queue_free()

##OLD SCRIPT##

#We use the word export to export the variable to the inspector, we have a set
#number for this variable, which we call later in the script for our speed
#export var speed = 500

#This variable stores a Vector3, right now it is set to Vector2(0, 0) or Vector2.ZERO
#onready var movementDirection = Vector2.ZERO

#we create a new variable and than within that variable we use the move_and_collide
#function that is built into the game engine, to not only move the bullet but
#detect if it is colliding with something.
	#var collision = move_and_collide(movementDirection.normalized() * delta * speed)
#If it is colliding than we call on the Portal function and the in-built 
#queue_free function to delete the node.
	#if collision:
	#	queue_free()

#Here we have a function that is called in the Turret script, inside this function
#we set a new variable pointDirection to a Vector2 point.
#func MoveSetup(pointDirection: Vector2):
#Then we set the movementDirection variable to the new pointDirection.
	#movementDirection = pointDirection

#This is another area2D node that has a signal function on it, when the player
#enters the area2D that the script is attatched to, than the health of the player
#goes down by 20.
