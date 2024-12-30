extends CharacterBody2D

const SPEED = 900.0
const REACTION_DISTANCE = 400  # Distance at which paddle starts reacting to ball
const PERFECT_TRACKING = 50    # How close to perfectly track the ball
const PREDICTION_WEIGHT = 0.7  # How much to consider ball's velocity for prediction
const SMOOTHING = 0.2         # Lower = smoother movement

var paddle_num = str
var target_y = 0.0
var current_speed = 0.0

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
				ai_opponent(delta)
				move_and_collide(velocity * delta)	
		else:
			velocity.y = Input.get_axis("move_up_p%s" % paddle_num, "move_down_p%s" % paddle_num) * SPEED
			move_and_collide(velocity * delta)

func ai_opponent(_delta):
	var ball = get_parent().get_node("Ball")
	var ball_vel = ball.velocity if "velocity" in ball else Vector2.ZERO
	
	var predicted_y = ball.position.y
	if abs(position.x - ball.position.x) < REACTION_DISTANCE:
		predicted_y += ball_vel.y * PREDICTION_WEIGHT * (position.x - ball.position.x) / ball_vel.x
	
	target_y = predicted_y + randf_range(-PERFECT_TRACKING, PERFECT_TRACKING)
	
	var distance = target_y - position.y
	var desired_speed = clamp(distance / PERFECT_TRACKING, -1, 1) * SPEED
	
	current_speed = lerp(current_speed, desired_speed, SMOOTHING)
	velocity.y = current_speed
