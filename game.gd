extends Node2D

var score = {'Left': 0, 'Right': 0}
var sides = {0: "Left", 1: "Right"}
var center
var startFlag = false
signal restart(direction)

func _ready():
	center = get_viewport().get_visible_rect().size / 2
	
func start() -> void:
	score = {'Left': 0, 'Right': 0}
	for side in score.keys():
		update_score(side)
	
	$Ball.direction = Vector2(((-1) ** randi()), 0)
	$Ball.speed = 1200.0
	$Ball.velocity = $Ball.direction * $Ball.speed
	$CanvasLayer/Message.hide()
	
func _process(_delta):
	if Input.is_key_pressed(KEY_SPACE) and !startFlag:
		start()
		startFlag = true
		
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://menu.tscn")
		
	if score["Left"] == 9 or score["Right"] == 9:
		$Ball.position = center
		$Ball.direction = Vector2.ZERO
		
		$Paddle1.position.y = center.y
		$Paddle2.position.y = center.y
		
		$CanvasLayer/Message.text = str('Game Over \nPress "Escape" to exit and "Space" to restart')
		$CanvasLayer/Message.show()
		startFlag = false

func _on_goals_body_shape_entered(_body_rid, _body, _body_shape_index, local_shape_index):
	var side = sides[local_shape_index]
	score[side] += 1
	update_score(side)
	
	emit_signal("restart", Vector2(-1 if side == "Left" else 1, 0))
	$Goals/Score.play()
		
func update_score(side: String):
	get_node("CanvasLayer/Score%s" % side).text = str(score[side])
