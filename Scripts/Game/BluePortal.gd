extends StaticBody2D


func _ready():
	pass

func _process(delta):
	if Global.BluePortal == true && Input.is_action_just_pressed("PortalBlue"):
		queue_free()
		Global.Shoot = true
