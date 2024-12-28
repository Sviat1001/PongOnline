extends CharacterBody2D


const SPEED = 900.0

var direction = Vector2.ZERO
func _ready():
	var center = position
	print(center)
	randomize()
	direction = Vector2(((-1) ** randi()), 0)
	print(direction)

func _physics_process(_delta):
	velocity = direction * SPEED
	move_and_slide()
