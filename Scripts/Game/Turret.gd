extends Node2D

onready var rotationSpeed = 200

export (PackedScene) var BulletScene

onready var turret = $"."
onready var rayCast = $AnimatedSprite/RayCast2D
onready var Barrel = $Position2D

var canShoot = true

func _ready():
	pass

func _process(delta):
	if Global.Paused == false:
		turret.rotation_degrees += rotationSpeed * delta
		Shoot()

func Shoot():
	if rayCast.is_colliding() && canShoot == true:
		if rayCast.get_collider().is_in_group("Player1"):
			var Bullet = BulletScene.instance()
			get_parent().add_child(Bullet)
			Bullet.global_position = Barrel.global_position
			Bullet.rotation_degrees = turret.rotation_degrees + 90
			Bullet.MoveSetup(rayCast.get_collision_point() - position)
			canShoot = false
			BulletTimer()

func BulletTimer():
	yield(get_tree().create_timer(.5), "timeout")
	canShoot = true
