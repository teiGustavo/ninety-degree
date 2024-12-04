class_name PauseMenu
extends BaseUtilMenu


@onready var play_button: UIButton = $Buttons/Play/PlayButton
@onready var exit_button: UIButton = $Buttons/Exit/ExitButton


func _ready() -> void:
	play_button.pressed.connect(hide_menu)
	exit_button.pressed.connect(_on_exit_button_pressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_pause_menu"):
		var cheat_menu: CheatMenu = get_parent().get_node("CheatMenu")
		
		if not cheat_menu or not cheat_menu.visible:
			toggle_visibility()

func _on_exit_button_pressed() -> void:
	hide_menu()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
