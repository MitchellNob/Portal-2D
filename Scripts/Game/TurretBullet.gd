extends KinematicBody2D

export var speed = 500

onready var movementDirection = Vector2.ZERO

func _process(delta):
	var collision = move_and_collide(movementDirection.normalized() * delta * speed)
	if collision:
		queue_free()

func MoveSetup(pointDirection: Vector2):
	movementDirection = pointDirection

func _on_Area2D_area_entered(area):
	if area.is_in_group("Player1"):
		Global.Health -= 20
