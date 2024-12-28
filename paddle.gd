extends CharacterBody2D

const SPEED = 800.0
var paddle_num = str

func _ready():
	paddle_num = name.replace("Paddle", "")
	
func _physics_process(_delta):
	velocity.y = Input.get_axis("move_up_p%s" % paddle_num, "move_down_p%s" % paddle_num) * SPEED
	move_and_slide()
