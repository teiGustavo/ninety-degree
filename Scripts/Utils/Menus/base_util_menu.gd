class_name BaseUtilMenu
extends CanvasLayer


func _ready() -> void:
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS

func show_menu() -> void:
	show()
	get_tree().paused = true

func hide_menu() -> void:
	hide()
	get_tree().paused = false

func toggle_visibility() -> void:
	if not visible:
		show_menu()
	else:
		hide_menu()
