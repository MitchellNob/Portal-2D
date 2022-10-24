extends KinematicBody2D

var velocity = Vector2.ZERO
export var speed = 700
var Shooting = false

onready var OrangeBullet = $"."

export (PackedScene) var orange_portal
	
func _physics_process(delta):
	var collision = move_and_collide(velocity.normalized() * delta * speed)
	if collision:
		Portal(delta)
		queue_free()

func set_direction(direction: Vector2):
	self.direction = direction

func Portal(delta):
		var OPortal = orange_portal.instance()
		get_parent().add_child(OPortal)
		OPortal.global_position = OrangeBullet.global_position
		Global.BluePortal = true
		Global.OrangeShot = false

func _on_Area2D_area_entered(area):
	if area.is_in_group("BluePortal"):
		queue_free()
		Global.OrangeShot = false
	if area.is_in_group("DeadWall"):
		queue_free()
		Global.OrangeShot = false

#####REFER TO BlueBullet FOR EXPLENATION OF CODE######
