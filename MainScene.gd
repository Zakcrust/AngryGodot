extends Node2D




enum {
	INIT
	IDLE,
	LAUNCHING,
	LAUNCHED
}

var state = INIT
var choosen_bird : RigidBody2D
var bird_pool


var allow_launch : bool = false

func _process(delta):
	match(state):
		IDLE:
			choosen_bird.global_position = $BirdPool.global_position
		LAUNCHING:
			$LaunchArea.look_at(get_global_mouse_position())
			choosen_bird.global_position = get_global_mouse_position()
			choosen_bird.global_position.x = clamp(choosen_bird.position.x, ($LaunchArea.position.x - 70) * cos($LaunchArea.rotation_degrees), ($LaunchArea.position.x + 70) * cos($LaunchArea.rotation_degrees))
			choosen_bird.global_position.y = clamp(choosen_bird.position.y, ($LaunchArea.position.y - 70) * sin($LaunchArea.rotation_degrees), ($LaunchArea.position.y + 70) * sin($LaunchArea.rotation_degrees))
			
			if Input.is_action_just_released("left_click"):
				if allow_launch:
					state = LAUNCHED
				else:
					state = IDLE
		LAUNCHED:
#			choosen_bird.global_transform = $LaunchArea.global_transform
			choosen_bird.mode = RigidBody2D.MODE_RIGID
			choosen_bird.launch()


func _on_LaunchArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			state = LAUNCHING
			bird_pool = $BirdPool.get_children()
			choosen_bird = bird_pool.front()


func _on_LaunchArea_mouse_entered():
	allow_launch = false


func _on_LaunchArea_mouse_exited():
	allow_launch = true
