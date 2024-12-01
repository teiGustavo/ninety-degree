class_name PauseMenu
extends CanvasLayer


@onready var play_button: UIButton = $Buttons/Play/PlayButton
@onready var exit_button: UIButton = $Buttons/Exit/ExitButton


func _ready() -> void:
	play_button.pressed.connect(_unpause)
	exit_button.pressed.connect(_on_exit_button_pressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if not visible:
			_pause()
		else:
			_unpause()

func _pause() -> void:
	show()
	get_tree().paused = true

func _unpause() -> void:
	hide()
	get_tree().paused = false

func _on_exit_button_pressed() -> void:
	_unpause()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
