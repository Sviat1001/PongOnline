extends CharacterBody2D

const SPEED = 900.0
var paddle_num = str

func _ready():
	paddle_num = name.replace("Paddle", "")
	
func _physics_process(delta):
	if get_parent().startFlag:
#		if AI:
			
#		else:
		velocity.y = Input.get_axis("move_up_p%s" % paddle_num, "move_down_p%s" % paddle_num) * SPEED
		move_and_collide(velocity * delta)
