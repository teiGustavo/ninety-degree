class_name NoScaleUpPowerUp
extends BasePlayerPowerUp


func can_applied() -> bool:
	return true if not Cheats.is_enabled(Cheats.Cheat.NO_SCALE_UP) else false

func apply() -> void:
	super.apply()
	
	player.no_scale_up = true
	player.reset_scale()
	
func remove() -> void:
	super.remove()
	
	player.no_scale_up = false
