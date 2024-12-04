extends Node


signal cheat_toggled(cheat: Cheat, toggled_on: bool)

enum Cheat {
	IMORTAL,
	NO_SCALE_UP,
	NOT_SPAWN_ENEMIES,
	SPAWN_POWER_UP,
}

var enabled: Array[Cheat] = []
var blocked: Array[Cheat] = []


func is_enabled(cheat: Cheat) -> bool:
	return cheat in enabled

func block_cheat(cheat: Cheat) -> void:
	if cheat not in blocked:
		blocked.append(cheat)
		
func unblock_cheat(cheat: Cheat) -> void:
	if cheat in blocked:
		blocked.erase(cheat)

func is_blocked(cheat: Cheat) -> bool:
	return cheat in blocked
	
func reset_blocked_cheats() -> void:
	blocked = []

func toggle_cheat(cheat: Cheat) -> void:
	if is_blocked(cheat):
		return
	
	var toggled_on: bool
	
	if cheat not in enabled:
		toggled_on = true
		enabled.append(cheat)
	else:
		toggled_on = false
		enabled.erase(cheat)	
	
	cheat_toggled.emit(cheat, toggled_on)
