extends Node2D

#Export a PackedScene to the inspector, we then store this PackedScene as a variable.
export(PackedScene) var Bullet

#We then set an integer variable that we will wan the turret to rotate at
onready var RotationSpeed = 200

#Here we set the target variable to nothing as there is currently no target.
var target: Node2D = null

#Here we call upon the different nodes within the scene and assign them variables so that 
#we can call upon them later.
onready var Raycast = $RayCast2D
onready var TurretSprite = get_node("AnimatedSprite")
onready var Reload = $RayCast2D/Reload
onready var Position = $RayCast2D/Position2D

#When the script is run, we set the target variable to the function FindPlayer()
func _ready():
	target = FindPlayer()

#In this physics_process function we play the animation Monitor (Idle), however if the variable target
#doesn't equal nothing and the Global.Paused boolean variable is equal to false, we run the rest of the
#script.
func _physics_process(delta):
	TurretSprite.play("Monitor")
	if target != null && Global.Paused == false:
#Here we are creating a new variable and using the in_built statements direction_to() and angle(), we are able to give
#it the angle needed to rotate us towards the direction of their global position.
		var angle_to_player: float = global_position.direction_to(target.global_position).angle()
#We then set the raycasts rotation towards the angle_to_player variable that we just calculated.
		Raycast.global_rotation = angle_to_player
#if the raycast is colliding with something and what it's colliding with is in the group "Player1",
#run the rest of the script.
		if Raycast.is_colliding() && Raycast.get_collider().is_in_group("Player1"):
#We set the rotation of the animated turret sprite the angle_to_player variable we made earlier, then
#using the in-built timer function is_stopped, we check to see if the Reload timer has timedout. If it
#has then we set the animation to shoot and we call upon the Shoot() function.
			TurretSprite.rotation = angle_to_player
			if Reload.is_stopped():
				TurretSprite.play("Active")
				Shoot()

func Shoot():
#When the shoot function is called we first disable the Raycast so that the turret can no longer rotate
#towards the player.
	Raycast.enabled = false
#We then have an if statement that says if the Variable Bullet is equal to true, run the rest of the script.
	if Bullet:
#Here we an instance a bullet (I have already explained Scene instancing), we then set the instanced bullets
#position to the Position node already loaded and the rotation to the Raycasts rotation.
		var bullet: Node2D = Bullet.instance()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = Position.global_position
		bullet.global_rotation = Raycast.global_rotation

#We then also start the Reload timer, once this goes off then the Turret will be able to shoot again.
	Reload.start()

func FindPlayer():
	var new_target: Node2D = null
	
	if get_tree().has_group("Player1"):
		new_target = get_tree().get_nodes_in_group("Player1")[0]
	return new_target

func _on_Reload_timeout():
	Raycast.enabled = true
