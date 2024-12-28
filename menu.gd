extends Control


func _ready() -> void:	
	var window = get_window()
	window.mode = Window.MODE_WINDOWED	
	window.position = DisplayServer.screen_get_position()
	window.size = DisplayServer.screen_get_usable_rect().size
	window.min_size = Vector2i(800,600)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
