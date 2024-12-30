extends Control

var game_scene

func _ready() -> void:    
	var window = get_window()
	window.mode = Window.MODE_FULLSCREEN
	window.position = DisplayServer.screen_get_position()
	window.size = DisplayServer.screen_get_usable_rect().size
	window.min_size = Vector2i(800,600)
	game_scene = preload("res://game.tscn")
	
func _on_play_ai_button_pressed() -> void:
	var game = load("res://game.tscn").instantiate()
	game.AI = true
	get_tree().root.add_child(game)
	queue_free()

func _on_play_button_pressed() -> void:
	var game = load("res://game.tscn").instantiate()
	game.AI = false
	get_tree().root.add_child(game)
	queue_free()

func _on_exit_button_pressed() -> void:
	get_tree().quit()
