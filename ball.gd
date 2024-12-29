extends CharacterBody2D


var speed = 0.0
var speedIncrease = 0.0
var direction = 0.0

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		
		if collision.get_collider() is CharacterBody2D:
			var paddlePosition = collision.get_collider().global_position
			direction = paddlePosition.direction_to(global_position)			
			direction.y = direction.y / 2
			
			speed += speed * speedIncrease
			if speed > 4800:
				speedIncrease = 0

			velocity = direction.normalized() * speed
			$Hit.play()
			
		else:
			velocity = velocity.bounce(collision.get_normal())
			$WallHit.play()

func _on_timer_timeout() -> void:
	speedIncrease = 0.05


func _on_game_restart(dir: Vector2):
	position = Vector2(get_parent().center.x, get_parent().center.y)
	speed = 1200.0
	velocity = dir * speed
