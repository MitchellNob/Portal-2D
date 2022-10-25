extends KinematicBody2D

#We use the word export to export the variable to the inspector, we have a set
#number for this variable, which we call later in the script for our speed
export var speed = 500

#This variable stores a Vector3, right now it is set to Vector2(0, 0) or Vector2.ZERO
onready var movementDirection = Vector2.ZERO


func _process(delta):
#we create a new variable and than within that variable we use the move_and_collide
#function that is built into the game engine, to not only move the bullet but
#detect if it is colliding with something.
	var collision = move_and_collide(movementDirection.normalized() * delta * speed)
#If it is colliding than we call on the Portal function and the in-built 
#queue_free function to delete the node.
	if collision:
		queue_free()

#Here we have a function that is called in the Turret script, inside this function
#we set a new variable pointDirection to a Vector2 point.
func MoveSetup(pointDirection: Vector2):
#Then we set the movementDirection variable to the new pointDirection.
	movementDirection = pointDirection

#This is another area2D node that has a signal function on it, when the player
#enters the area2D that the script is attatched to, than the health of the player
#goes down by 20.
func _on_Area2D_area_entered(area):
	if area.is_in_group("Player1"):
		Global.Health -= 20
