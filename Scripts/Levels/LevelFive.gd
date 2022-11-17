extends Node2D

##REFER TO "LevelOne" FOR EXPLENATION OF CODE##

onready var ElevatorDoor = $KinematicBody2D2/CollisionShape2D

func _process(delta):
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
	if Global.Key == true:
		ElevatorDoor.disabled = true


func _on_Elevator_area_entered(area):
	if area.is_in_group("Player1") && Global.Key == true:
		get_tree().change_scene("res://Scenes/Levels/EndScene.tscn")
		Global.Key = false
		Global.CompanionCube = false
		Global.Health = 100
