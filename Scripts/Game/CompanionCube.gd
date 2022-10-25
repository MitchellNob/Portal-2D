extends Node2D

#A boolean variable that stores whether or not we have the companion cube picked up or not.
var PickUp = false


func _process(delta):
#The process function first checks to see if the PickUp variable is equal to 
#true, if it is and the space button is pressed, we delete the node the script
#is attached to and we set the Global variable CompanionCube to true, the player
#has now "picked up" the cube.
	if PickUp == true && Input.is_action_just_pressed("Space"):
		queue_free()
		Global.CompanionCube = true

#If the Global variable KillCube is equal to true, we destroy this node and set 
#the variable back to false.
	if Global.KillCube == true:
		queue_free()
		Global.KillCube = false

#Another area2D using the inbuilt signal function to determine if another area
#other than it's own has entered its vicinity.
func _on_Area2D_area_entered(area): 
#If the area that has entered is within the group "Player1", then we set PickUp 
#to true.
	if area.is_in_group("Player1"):
		PickUp = true

#This area2D function works similar to the one above, instead, when an area leaves
#other than its own leaves its area, it runs the rest of the function.
func _on_Area2D_area_exited(area):
#If the area that has entered is within the group "Player1", then we set PickUp 
#to false. 
	if area.is_in_group("Player1"):
		PickUp = false
