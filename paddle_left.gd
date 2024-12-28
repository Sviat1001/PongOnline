extends CharacterBody2D


const SPEED = 800.0
var ai = true
func _physics_process(_delta):
	velocity.y = Input.get_axis("move_up_p1", "move_down_p1") * SPEED
	move_and_slide()
