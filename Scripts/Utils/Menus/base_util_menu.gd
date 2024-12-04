class_name BaseUtilMenu
extends CanvasLayer


func _ready() -> void:
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS

func pause() -> void:
	show()
	get_tree().paused = true

func unpause() -> void:
	hide()
	get_tree().paused = false

func toggle_pause() -> void:
	if not visible:
		pause()
	else:
		unpause()
