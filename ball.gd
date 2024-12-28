extends CharacterBody2D


var speed = 1200

func _ready():
	var direction = Vector2(((-1) ** randi()), 0)
	velocity = direction * speed
	var speedIncrease = 0

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		
		if collision.get_collider() is CharacterBody2D:
			var paddlePosition = collision.get_collider().global_position
			var direction = paddlePosition.direction_to(global_position)
			
			direction.y = direction.y / 1.5
			velocity = direction.normalized() * speed
			$Hit.play()
			
		else:
			velocity = velocity.bounce(collision.get_normal())
			$WallHit.play()

func _on_timer_timeout() -> void:
	pass # Replace with function body.
