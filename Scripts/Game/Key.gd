extends Node2D

#Here we have a simple script for our elevator key, using the area2D node again
#with a signal function we detect if the area that has just entered is in the
#group "Player1", if it is than we set the Global variable Key to true, meaning
#that the player is now holding the elevator key. It than deletes the key node.
func _on_Area2D_area_entered(area):
	if area.is_in_group("Player1"):
		Global.Key = true
		queue_free()
