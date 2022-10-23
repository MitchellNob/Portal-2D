extends KinematicBody2D

onready var collision = get_node("CollisionShape2D")

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Global.PressurePlate == true:
		visible = false
		collision.disabled = true
	else:
		visible = true 
		collision.disabled = false
