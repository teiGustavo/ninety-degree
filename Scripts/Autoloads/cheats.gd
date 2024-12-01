extends Node


signal cheat_toggled(cheat: Cheat)

enum Cheat {
	IMORTAL,
	NO_SCALE_UP,
	NOT_SPAWN_ENEMIES,
	SPAWN_POWER_UP,
}


func toggle_cheat(cheat: Cheat) -> void:
	cheat_toggled.emit(cheat)
