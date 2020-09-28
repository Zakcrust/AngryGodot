extends RigidBody2D


var force : int = 1000

func _ready():
	mode = RigidBody2D.MODE_KINEMATIC


func launch():
	linear_velocity = transform.x * force
