extends Node2D

#Simple script that loads the Main Menu scene when the Button signal is activated when pressing the 
#button.
func _on_Button_button_down():
	get_tree().change_scene("res://Scenes/Menu/MainMenu.tscn")
