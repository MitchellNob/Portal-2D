extends Node2D

#Here we are calling all of the different nodes that will be used in this script
#later on and assigning them to different variables.
onready var ElevatorDoor = $KinematicBody2D2/CollisionShape2D
onready var Greetings = get_node("Tutorial/Greetings/Text")
onready var Greetings2 = get_node("Tutorial/Greetings/Text2")
onready var ElevatorKey = get_node("Tutorial/Key/Text")
onready var Turret = get_node("Tutorial/Turret/Text")
onready var CompanionCube = get_node("Tutorial/CompanionCube/Text")
onready var PressurePlate = get_node("Tutorial/PressurePlate/Text")
onready var Door = get_node("Tutorial/Door/Text")

#This is all of the boolean variables determining if we have already gone through
#the tutorial area or not
var GreetingPanel = true
var TurretPanel = true
var KeyPanel = true
var CompanionCubePanel = true
var PressurePlatePanel = true
var DoorPanel = true

#In the process function we call on the AudioStreamPlayer within our node tree, 
#then using an inbuilt function we play the audio that the AudioStreamPlayer has
#in its audio stream. It also sets the ElevatorDoor to disabled if th e global variable
#is equal to true (if the player has grabbed the elevator key)
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

#Here we have a set of area2D signal functions, they are all very similar, first
#the function checks to see if the area that has entered the area2D is the player
#it than sets the respective tutorial panel to visible and the associated boolean
#variable to false so that it can no longer be called after you have exited the tutorial.
#It also sets the Global variable Paused to true so that the game pauses, when the
#button is pressed on the tutorial it sets the popups visibility back to false and
#the Pause variable to false.

#When the player enters the Greeting Area.
func _on_Greetings_area_entered(area):
	if area.is_in_group("Player1")  && GreetingPanel == true:
		print_debug("hello")
		Greetings.visible = true
		Global.Paused = true

#When the player presses Greeting continue button.
func _on_Greetings_button_down():
	Greetings.visible = false
	Greetings2.visible = true

#When the player presses Greeting2 continue button.
func _on_Greetings2_button_down():
	Greetings2.visible = false
	Global.Paused = false
	GreetingPanel = false

#When the player enters the Turret area.
func _on_Turret_area_entered(area):
	if area.is_in_group("Player1")  && TurretPanel == true:
		Turret.visible = true
		Global.Paused = true

#When the player presses Turret continue button.
func _on_Turret_button_down():
	Turret.visible = false
	Global.Paused = false
	TurretPanel = false

#When the player enters the Key area.
func _on_Key_area_entered(area):
	if area.is_in_group("Player1")  && KeyPanel == true:
		ElevatorKey.visible = true
		Global.Paused = true

#When the player presses Key continue button.
func _on_Key_button_down():
	ElevatorKey.visible = false
	Global.Paused = false
	KeyPanel = false

#When the player enters the CompanionCube area.
func _on_CompanionCube_area_entered(area):
	if area.is_in_group("Player1")  && CompanionCubePanel == true:
		CompanionCube.visible = true
		Global.Paused = true

#When the player presses CompanionCube continue button.
func _on_CompanionCube_button_down():
	CompanionCube.visible = false
	Global.Paused = false
	CompanionCubePanel = false

#When the player enters the PressurePlate area.
func _on_PressurePlate_area_entered(area):
	if area.is_in_group("Player1")  && PressurePlatePanel == true:
		PressurePlate.visible = true
		Global.Paused = true

#When the player presses PressurePlate continue button.
func _on_PressurePlate_button_down():
	PressurePlate.visible = false
	Global.Paused = false
	PressurePlatePanel = false
