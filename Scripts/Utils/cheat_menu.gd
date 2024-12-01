class_name CheatMenu
extends CanvasLayer


signal cheat_activated(cheat: Cheat)

enum Cheat {
	IMORTAL,
	NO_SCALE_UP,
	NOT_SPAWN_ENEMIES,
	SPAWN_POWER_UP,
}

@onready var imortal_button: Button = $GridContainer/ImortalButton
@onready var no_scale_up_button: Button = $GridContainer/NoScaleUpButton
@onready var not_spawn_enemies_button: Button = $GridContainer/NotSpawnEnemiesButton
@onready var spawn_power_up_button: Button = $GridContainer/SpawnPowerUpButton


func _ready() -> void:
	imortal_button.pressed.connect(
		cheat_activated.emit.bind(Cheat.IMORTAL)
	)
	no_scale_up_button.pressed.connect(
		cheat_activated.emit.bind(Cheat.NO_SCALE_UP)
	)
	not_spawn_enemies_button.pressed.connect(
		cheat_activated.emit.bind(Cheat.NOT_SPAWN_ENEMIES)
	)
	spawn_power_up_button.pressed.connect(
		cheat_activated.emit.bind(Cheat.SPAWN_POWER_UP)
	)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_cheat_menu"):
		if not visible:
			show()
			get_tree().paused = true
		else:
			hide()
			get_tree().paused = false
