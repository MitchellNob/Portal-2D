extends Node2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()

func _on_Play_button_down():
	get_tree().change_scene("res://Scenes/LevelOne.tscn")

func _on_Level_Select_button_down():
	get_tree().change_scene("res://Scenes/LevelSelect.tscn")

func _on_Quit_button_down():
	get_tree().quit()


