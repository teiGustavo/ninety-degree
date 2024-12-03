extends Node


signal cheat_toggled(cheat: Cheat, toggled_on: bool)

enum Cheat {
	IMORTAL,
	NO_SCALE_UP,
	NOT_SPAWN_ENEMIES,
	SPAWN_POWER_UP,
}

var enabled: Array[Cheat] = []


func is_enabled(cheat: Cheat) -> bool:
	return cheat in enabled

func toggle_cheat(cheat: Cheat) -> void:
	var toggled_on: bool
	
	if cheat not in enabled:
		toggled_on = true
		enabled.append(cheat)
	else:
		toggled_on = false
		enabled.erase(cheat)	
	
	cheat_toggled.emit(cheat, toggled_on)
