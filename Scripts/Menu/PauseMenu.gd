extends Control

#variable that stores a setter and getter function, a setter function allows us to set a variable 
#and then also run it as a function, in this case we are setting the boolean variable to pause
#so that the pause menu isn't shown when the script is loaded.
var paused = false setget set_is_paused

#Here we just use the _unhandled_input so that the game checks for any inputs constantly
func _unhandled_input(event):
#Within the function we check to see if an event has occured, if an input has been pressed and it
#equal to the Escape key, then we set the boolean variable "paused" to the opposite of false; true.
	if event.is_action_pressed("Pause"):
		self.paused = !paused

#If the set_is_paused function is called in the variable then we store the value of paused, the value
#in this case is the boolean variable, which is set to true.
func set_is_paused(value):
#We then set the paused variable to the value that we obtained earler.
	paused = value
#We call upon an inbuilt function of Godot. paused stops all 2D and 3D Physics from being processed
#this includes any signals and collisions that may activate. We then go into the Godot inspector and
#change the background music and Pause menu so that they are processed even when the game is paused.
#It also says that it is equal to paused, this is because we set paused to true earlier, right now
#the boolean variable paused is set to true.
	get_tree().paused = paused
#We then set the visibility of the pause menu to the boolean variable paused, which in this instance 
#is true.
	visible = paused

#We use a signal function here that is connected to a button on the panel, when this button is pressed
#it uses an in-built function to change the scene from the current scene to the Main Meny scene.
#It also changes the paused variable to false, which means that Physics are processed again and it 
#gets rid of the pause menu.
func _on_MainMenu_button_down():
	self.paused = false
	get_tree().change_scene("res://Scenes/Menu/MainMenu.tscn")

#Here we simply set the paused variable to false, so that Physics can be processed again and the 
#pause menu can no longer be seen
func _on_Resume_button_down():
	self.paused = false

#If the Quit button is pressed then it uses an in-built function to close the game application
func _on_Quit_button_down():
	get_tree().quit()
