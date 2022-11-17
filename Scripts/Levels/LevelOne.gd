extends Node

#Here we are calling all of the different nodes that will be used in this script
#later on and assigning them to different variables.
onready var ExitDoor = $ExitBlocker/CollisionShape2D
onready var Greetings = get_node("Tutorial/Greetings/Text")
onready var Greetings2 = get_node("Tutorial/Greetings/Text2")

#This is all of the boolean variables determining if we have already gone through
#the tutorial area or not
var GreetingPanel = true

#In the process function we call on the AudioStreamPlayer within our node tree, 
#then using an inbuilt function we play the audio that the AudioStreamPlayer has
#in its audio stream. It also sets the ElevatorDoor to disabled if the global variable
#is equal to true (if the player has grabbed the elevator key)
func _process(delta):
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
	if Global.Key == true:
		ExitDoor.disabled = true
	Global.BlueShot = true
	Global.OrangeShot = true

#Here we have it so that when the Player enters the Elevators Area2D and the player has already picked
#up the key (indicated by the Global.Key being true), the scene is changed from LevelOne to LevelTwo
#we also reset most of the Global variables so that the game is "reset" when you go the next level.
#We set the Global.Key to true so that the player can't go to LevelThree as soon as he reaches 
#LevelTwo, we then make the Global.CompanionCube to false so that the player is no longer holding
#a CompanionCube. Finally we set the Global.Health to 100, which means that the player is full health.
func _on_Elevator_area_entered(area):
	if area.is_in_group("Player1") && Global.Key == true:
		get_tree().change_scene("res://Scenes/Levels/LevelTwo.tscn")
		Global.Key = false
		Global.CompanionCube = false
		Global.Health = 100

#Here we have a set of area2D signal functions, they are all very similar, first
#the function checks to see if the area that has entered the area2D is the player
#it than sets the respective tutorial panel to visible and the associated boolean
#variable to false so that it can no longer be called after you have exited the tutorial.
#It also sets the Global variable Paused to true so that the game pauses. When the
#button is pressed on the tutorial it sets the popups visibility back to false and
#the Pause variable to false.

func _on_Greetings_area_entered(area):
	if area.is_in_group("Player1")  && GreetingPanel == true:
		Greetings.visible = true
		Global.Paused = true

func _on_Greetings_button_down():
	Greetings.visible = false
	Greetings2.visible = true

func _on_Greetings2_button_down():
	Greetings2.visible = false
	yield(get_tree().create_timer(.5), "timeout")
	GreetingPanel = false
	Global.Paused = false
