class_name CheatMenu
extends Panel


signal cheat_activated(cheat)

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
	imortal_button.pressed.connect(cheat_activated.emit)
	no_scale_up_button.pressed.connect(cheat_activated.emit)
	not_spawn_enemies_button.pressed.connect(cheat_activated.emit)
	spawn_power_up_button.pressed.connect(cheat_activated.emit)
