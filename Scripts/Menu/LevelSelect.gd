extends Node2D

#Because we don't have a ready function we use the onready statement so that the variable is loaded
#as the script is loaded. We call all of the different Panel nodes within the Scene and assign
#them a variable to call on later.
onready var Panel1 = get_node("Panel1")
onready var Panel2 = get_node("Panel2")
onready var Panel3 = get_node("Panel3")

#Here we have a few signal function that change a panels visibility within the scene, depending on
#what next and back button has been pressed
func _on_Next_button_down():
	Panel2.visible = true
	Panel1.visible = false

func _on_Next2_button_down():
	Panel2.visible = false
	Panel3.visible = true

func _on_Back2_button_down():
	Panel2.visible = false
	Panel1.visible = true

func _on_Back3_button_down():
	Panel3.visible = false
	Panel2.visible = true

#Here we have the level select buttons themselves, each button also has a signal function that is called
#on in this script. Each button will take you to a different level using the in-built function 
#change_scene.
func _on_Button_button_down():
	get_tree().change_scene("res://Scenes/Levels/LevelOne.tscn")

func _on_Exit_button_down():
	get_tree().change_scene("res://Scenes/Menu/MainMenu.tscn")

func _on_Button2_button_down():
	get_tree().change_scene("res://Scenes/Levels/LevelTwo.tscn")

func _on_Button3_button_down():
	get_tree().change_scene("res://Scenes/Levels/LevelThree.tscn")

func _on_Button4_button_down():
	get_tree().change_scene("res://Scenes/Levels/LevelFour.tscn")

func _on_Button5_button_down():
	get_tree().change_scene("res://Scenes/Levels/LevelFive.tscn")
