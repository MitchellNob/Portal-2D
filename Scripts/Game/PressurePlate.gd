extends Node2D

var Enabled = false
onready var anim = get_node("AnimatedSprite")

func _ready():
	pass;

func _process(delta):
	if Global.PressurePlate == true:
		Enabled()

func Enabled():
	anim.play("Active")

func _on_Area2D_area_entered(area):
	if area.is_in_group("CompanionCube"):
		Global.PressurePlate = true

func _on_Area2D_area_exited(area):
	if area.is_in_group("CompanionCube"):
		Global.PressurePlate= false
		anim.play("default")
