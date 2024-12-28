extends CharacterBody2D


const SPEED = 800.0

func _physics_process(_delta):
	velocity.y = Input.get_axis("move_up_p2", "move_down_p2") * SPEED
	move_and_slide()
