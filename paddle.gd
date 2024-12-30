extends CharacterBody2D

const SPEED = 900.0
var paddle_num = str

func _ready():
	paddle_num = name.replace("Paddle", "")
	
func _physics_process(delta):
	if get_parent().startFlag:
		if get_parent().AI:
			if paddle_num == '1':
				var input1 = Input.get_axis("move_up_p1", "move_down_p1")
				var input2 = Input.get_axis("move_up_p2", "move_down_p2")
				var normalizedInput = Vector2(0, input1 + input2).normalized()
				
				velocity.y = (normalizedInput.y) * SPEED
				move_and_collide(velocity * delta)

			if paddle_num == '2':
				ai_opponent()
				move_and_collide(velocity * delta)	
		else:
			velocity.y = Input.get_axis("move_up_p%s" % paddle_num, "move_down_p%s" % paddle_num) * SPEED
			move_and_collide(velocity * delta)

func ai_opponent():
	if get_parent().get_node("Ball").position.y > (position.y + 50):
		velocity.y = SPEED
	elif get_parent().get_node("Ball").position.y < (position.y - 50):
		velocity.y = -SPEED
	else:
		velocity.y = 0
