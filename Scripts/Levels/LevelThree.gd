extends Node2D

##REFER TO "LevelOne" FOR EXPLENATION OF CODE##

onready var ExitDoor = $ExitBlocker/CollisionShape2D
onready var Greetings = get_node("Tutorial/Greetings/Text")

var GreetingPanel = true

func _process(delta):
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
	if Global.Key == true:
		ExitDoor.disabled = true
	Global.BlueShot = true
	Global.OrangeShot = true

func _on_Elevator_area_entered(area):
	if area.is_in_group("Player1") && Global.Key == true:
		get_tree().change_scene("res://Scenes/Levels/LevelFour.tscn")
		Global.Key = false
		Global.CompanionCube = false
		Global.Health = 100

func _on_Greetings_area_entered(area):
	if area.is_in_group("Player1")  && GreetingPanel == true:
		Greetings.visible = true
		Global.Paused = true
		
func _on_Button_button_down():
	Greetings.visible = false
	GreetingPanel = false
	yield(get_tree().create_timer(.5), "timeout")
	Global.Paused = false
	
