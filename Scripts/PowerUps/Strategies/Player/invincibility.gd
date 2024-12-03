class_name InvincibilityPowerUp
extends BasePlayerPowerUp


func can_applied() -> bool:
	return true if not Cheats.is_enabled(Cheats.Cheat.IMORTAL) else false

func apply() -> void:
	super.apply()
	
	player.imortal = true

func remove() -> void:
	super.remove()
	
	player.imortal = false
