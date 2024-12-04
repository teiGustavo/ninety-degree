class_name PauseMenu
extends BaseUtilMenu


@onready var play_button: UIButton = $Buttons/Play/PlayButton
@onready var exit_button: UIButton = $Buttons/Exit/ExitButton


func _ready() -> void:
	play_button.pressed.connect(unpause)
	exit_button.pressed.connect(_on_exit_button_pressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()

func _on_exit_button_pressed() -> void:
	unpause()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
