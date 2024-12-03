class_name CheatMenu
extends CanvasLayer


@onready var imortal_button: Button = $GridContainer/ImortalButton
@onready var no_scale_up_button: Button = $GridContainer/NoScaleUpButton
@onready var not_spawn_enemies_button: Button = $GridContainer/NotSpawnEnemiesButton
@onready var spawn_power_up_button: Button = $GridContainer/SpawnPowerUpButton


func _ready() -> void:
	imortal_button.pressed.connect(
		Cheats.toggle_cheat.bind(Cheats.Cheat.IMORTAL)
	)
	no_scale_up_button.pressed.connect(
		Cheats.toggle_cheat.bind(Cheats.Cheat.NO_SCALE_UP)
	)
	not_spawn_enemies_button.pressed.connect(
		Cheats.toggle_cheat.bind(Cheats.Cheat.NOT_SPAWN_ENEMIES)
	)
	spawn_power_up_button.pressed.connect(
		Cheats.toggle_cheat.bind(Cheats.Cheat.SPAWN_POWER_UP)
	)
	
	imortal_button.set_pressed_no_signal(
		Cheats.is_enabled(Cheats.Cheat.IMORTAL)
	)
	no_scale_up_button.set_pressed_no_signal(
		Cheats.is_enabled(Cheats.Cheat.NO_SCALE_UP)
	)
	not_spawn_enemies_button.set_pressed_no_signal(
		Cheats.is_enabled(Cheats.Cheat.NOT_SPAWN_ENEMIES)
	)
	spawn_power_up_button.set_pressed_no_signal(
		Cheats.is_enabled(Cheats.Cheat.SPAWN_POWER_UP)
	)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_cheat_menu"):
		if not visible:
			show()
			get_tree().paused = true
		else:
			hide()
			get_tree().paused = false
