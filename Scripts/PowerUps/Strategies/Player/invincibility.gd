class_name InvincibilityPowerUp
extends BasePlayerPowerUp


func can_applied() -> bool:
	return true if not player.imortal else false

func apply() -> void:
	super.apply()
	
	player.imortal = true

func remove() -> void:
	super.remove()
	
	player.imortal = false
