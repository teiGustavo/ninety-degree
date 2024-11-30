class_name InvincibilityPowerUp
extends BasePowerUp


func apply() -> void:
	super.apply()
	
	if player.imortal:
		allowed = false
		return
	
	player.imortal = true
	
func revert() -> void:
	super.revert()
	
	player.imortal = false
