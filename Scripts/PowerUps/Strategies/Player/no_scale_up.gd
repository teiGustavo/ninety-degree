class_name NoScaleUpPowerUp
extends BasePlayerPowerUp


const CHEAT: Cheats.Cheat = Cheats.Cheat.NO_SCALE_UP


func can_applied() -> bool:
	return true if not Cheats.is_enabled(CHEAT) else false

func can_removed() -> bool:
	return can_applied()

func apply() -> void:
	super.apply()
	
	player.no_scale_up = true
	player.reset_scale()
	Cheats.block_cheat(CHEAT)
		
func remove() -> void:
	super.remove()
	
	player.no_scale_up = false
	Cheats.unblock_cheat(CHEAT)
