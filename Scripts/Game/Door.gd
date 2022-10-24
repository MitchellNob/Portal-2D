extends KinematicBody2D

#Here we are storing a node within our scene as collision, in this case it is
#the CollisionShape2D for our door.
onready var collision = get_node("CollisionShape2D")


func _process(delta):
#In the process function here we are checking to see if the Global variable 
#PressurePlate is true, or that the pressure plate is active, if it is true
#we set it so that you can no longer see the door and collision is disabled.
	if Global.PressurePlate == true:
		visible = false
		collision.disabled = true
#We use the else function to say that if the above "if" statement is not true 
#than set it so that the player can collide and see the door again.
	else:
		visible = true 
		collision.disabled = false
