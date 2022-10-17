extends KinematicBody2D

var velocity = Vector2.ZERO
export var speed = 400
var Shooting = false

onready var BlueBullet = $"."

export (PackedScene) var blue_portal
	
func _physics_process(delta):
	var collision = move_and_collide(velocity.normalized() * delta * speed)
	if collision:
		Portal(delta)
		queue_free()

func set_direction(direction: Vector2):
	self.direction = direction

func Portal(delta):
		var Portal = blue_portal.instance()
		get_parent().add_child(Portal)
		Portal.global_position = BlueBullet.global_position
		Global.BluePortal = true
	
