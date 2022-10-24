extends Area2D

#This variable just gets the node BluePos from our scene, this node is a Position2D
#so it holds a Vector2D x and y value
onready var BluePos = $BluePos

#here we call the _physics_process again
func _physics_process(delta):
#we call upon the gloval variable again for BluePortal, if it is equal to true 
#and the is lmb is being pressed
	if Global.BluePortal == true && Input.is_action_just_pressed("BluePortal"):
#The queue_free function deletes the node that the script is attatched to, in 
#this case the portal
		queue_free()
#We than set the variable to true
		Global.BluePortal = true
