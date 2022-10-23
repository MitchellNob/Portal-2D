extends KinematicBody2D

var velocity = Vector2.ZERO
export var speed = 700
var Shooting = false

onready var BlueBullet = $"."

export (PackedScene) var blue_portal
	
func _physics_process(delta):
	var collision = move_and_collide(velocity.normalized() * delta * speed)
	if collision:
		Portal(delta)
		queue_free()

func Portal(delta):
	var BPortal = blue_portal.instance()
	get_parent().add_child(BPortal)
	BPortal.global_position = BlueBullet.global_position
	Global.BluePortal = true
	Global.BlueShot = false
	
func _on_Area2D_area_entered(area):
	if area.is_in_group("OrangePortal"):
		queue_free()
		Global.BlueShot = false
	if area.is_in_group("DeadWall"):
		queue_free()
		Global.BlueShot = false
