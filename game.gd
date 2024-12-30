extends Node2D

var AI
var score = {'Left': 0, 'Right': 0}
var sides = {0: "Left", 1: "Right"}

var center

var startFlag = false

signal restart(direction)

func _ready():
	center = get_viewport().get_visible_rect().size / 2
	
func start():
	score = {'Left': 0, 'Right': 0}
	for side in score.keys():
		update_score(side)
	
	$Ball.direction = Vector2(((-1) ** randi()), 0)
	$Ball.speed = 1200.0
	$Ball.velocity = $Ball.direction * $Ball.speed
	$Ball/TimeOver.start(30)
	$Ball/TimeRestart.start(1)
	$CanvasLayer/Message.hide()

func _input(event):
	if event.is_action_pressed("space") and !startFlag:
		start()
		startFlag = true
	if event.is_action_pressed("esc") and !startFlag:
		queue_free()
		get_tree().change_scene_to_file("res://menu.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("esc"):
		if !get_tree().paused:
			$CanvasLayer/Message.text = str('The game is paused \nPress "Escape" to exit and "Space" to resume')
			$CanvasLayer/Message.show()
			get_tree().paused = !get_tree().paused
		else:
			queue_free()
			get_tree().change_scene_to_file("res://menu.tscn")
			
	elif event.is_action_pressed("space") and get_tree().paused:
		get_tree().paused = !get_tree().paused
		$CanvasLayer/Message.hide()
		
func _on_goals_body_shape_entered(_body_rid, body, _body_shape_index, local_shape_index):
	var side = sides[local_shape_index]
	score[side] += 1
	update_score(side)
	
	if score[side] == 9:
		body.position = center
		body.direction = Vector2.ZERO
		body.velocity = Vector2.ZERO
		
		$Paddle1.position.y = center.y
		$Paddle2.position.y = center.y
		if AI == false:
			$CanvasLayer/Message.text = str('Player ' + ("1" if side == "Left" else "2") + ' wins \nPress "Escape" to exit and "Space" to restart')
		else:
			$CanvasLayer/Message.text = str(("Player" if side == "Left" else "CPU") + ' wins \nPress "Escape" to exit and "Space" to restart')
		$CanvasLayer/Message.show()
		startFlag = false
		$Goals/Victory.play()
		return

	emit_signal("restart", Vector2(-1 if side == "Left" else 1, 0))
	$Goals/Score.play()
		
func update_score(side: String):
	get_node("CanvasLayer/Score%s" % side).text = str(score[side])
	$CanvasLayer/ScoreLeft.show()
	$CanvasLayer/ScoreRight.show()


func _on_time_restart_timeout() -> void:
	$CanvasLayer/ScoreLeft.hide()
	$CanvasLayer/ScoreRight.hide()
