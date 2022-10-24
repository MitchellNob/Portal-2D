extends Node2D

#In the process function here we get the AudioStreamPlayer from the node tree
#and use an inbuilt function to play the sound stream attatched to the 
#AudioSreamPlayer.
func _process(delta):
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()

#Here we are using a Button node with a signal function attatched to it, the 
#function checks to see if the button has been pressed. If it has been pressed
#than we get it to load a new scene.

#This function loads the LevelOne scene.
func _on_Play_button_down():
	get_tree().change_scene("res://Scenes/Levels/LevelOne.tscn")

#This function loads the LevelSelect scene
func _on_Level_Select_button_down():
	get_tree().change_scene("res://Scenes/Menu/LevelSelect.tscn")

#This function is a bit different and it uses an in-built function quit(), to
#close the game tab
func _on_Quit_button_down():
	get_tree().quit()


