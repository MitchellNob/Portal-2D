extends KinematicBody2D

var velocity = Vector2.ZERO
export var speed = 400
var Shooting = false

const blue_portal = preload("res://Scenes/Blue/BluePortal.tscn")

func _physics_process(delta):
	var collision = move_and_collide(velocity.normalized() * delta * speed)
	if collision:
		var BluePortal = blue_portal.instance()
		get_parent().add_child(BluePortal)
		Global.Shoot = false
		queue_free()

func set_direction(direction: Vector2):
	self.direction = direction
