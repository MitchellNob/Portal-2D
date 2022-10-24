extends Node2D

onready var ElevatorDoor = $KinematicBody2D2/CollisionShape2D
onready var Greetings = get_node("Tutorial/Greetings/Text")
onready var Greetings2 = get_node("Tutorial/Greetings/Text2")
onready var ElevatorKey = get_node("Tutorial/Key/Text")
onready var Turret = get_node("Tutorial/Turret/Text")
onready var CompanionCube = get_node("Tutorial/CompanionCube/Text")
onready var PressurePlate = get_node("Tutorial/PressurePlate/Text")
onready var Door = get_node("Tutorial/Door/Text")

var GreetingPanel = true
var TurretPanel = true
var KeyPanel = true
var CompanionCubePanel = true
var PressurePlatePanel = true
var DoorPanel = true


func _process(delta):
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
	if Global.Key == true:
		ElevatorDoor.disabled = true


func _on_Elevator_area_entered(area):
	if area.is_in_group("Player1") && Global.Key == true:
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
		Global.Key = false
		Global.CompanionCube = false
		Global.Health = 100

#When the player enters the Greeting Area
func _on_Greetings_area_entered(area):
	if area.is_in_group("Player1")  && GreetingPanel == true:
		print_debug("hello")
		Greetings.visible = true
		Global.Paused = true

#For Greetings
func _on_Greetings_button_down():
	Greetings.visible = false
	Greetings2.visible = true

#For Greetings2
func _on_Greetings2_button_down():
	Greetings2.visible = false
	Global.Paused = false
	GreetingPanel = false

#For Turret
func _on_Turret_area_entered(area):
	if area.is_in_group("Player1")  && TurretPanel == true:
		Turret.visible = true
		Global.Paused = true

#For Turret
func _on_Turret_button_down():
	Turret.visible = false
	Global.Paused = false
	TurretPanel = false

#For Key
func _on_Key_area_entered(area):
	if area.is_in_group("Player1")  && KeyPanel == true:
		ElevatorKey.visible = true
		Global.Paused = true

#For Key
func _on_Key_button_down():
	ElevatorKey.visible = false
	Global.Paused = false
	KeyPanel = false


func _on_CompanionCube_area_entered(area):
	if area.is_in_group("Player1")  && CompanionCubePanel == true:
		CompanionCube.visible = true
		Global.Paused = true


func _on_CompanionCube_button_down():
	CompanionCube.visible = false
	Global.Paused = false
	CompanionCubePanel = false


func _on_PressurePlate_area_entered(area):
	if area.is_in_group("Player1")  && PressurePlatePanel == true:
		PressurePlate.visible = true
		Global.Paused = true


func _on_PressurePlate_button_down():
	PressurePlate.visible = false
	Global.Paused = false
	PressurePlatePanel = false
