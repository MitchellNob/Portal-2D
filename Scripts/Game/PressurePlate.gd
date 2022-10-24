extends Node2D

#Boolean variable that checks to see if the pressure plate has been enabled.
var Enabled = false

#Here we get a node from the node tree called "AnimatedSprite", we than set this
#node to the variable Anim.
onready var Anim = get_node("AnimatedSprite")

#In this process function we have an if function that checks to see if the Global
#variable PressurePlate is equal to true. If it is than we play the Enabled() function.
func _process(delta):
	if Global.PressurePlate == true:
		Enabled()

#Here we use an in-built function from the animated sprite that we called in the
#variables, we play the animation within the node that has the name "Active".
func Enabled():
	Anim.play("Active")

#We use the area2D node with a signal function and check whether the area that entered
#the nodes area2D is in the group "CompanionCube", if it is we set the Global variable
#PressurePlate to true (the companion cube is now on the pressure plate).
func _on_Area2D_area_entered(area):
	if area.is_in_group("CompanionCube"):
		Global.PressurePlate = true

#When the companion cube exits the area2D we set the Global variable to false and 
#we play the animation "default".
func _on_Area2D_area_exited(area):
	if area.is_in_group("CompanionCube"):
		Global.PressurePlate= false
		Anim.play("default")
