extends Node2D

var PickUp = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if PickUp == true && Input.is_action_just_pressed("Space"):
		queue_free()
		Global.CompanionCube = true

func _on_Area2D_area_entered(area): 
	if area.is_in_group("Player1"):
		PickUp = true
		

func _on_Area2D_area_exited(area):
	if area.is_in_group("Player1"):
		PickUp = false
