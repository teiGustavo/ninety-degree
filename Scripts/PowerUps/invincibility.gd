class_name InvincibilityPowerUp
extends BasePowerUp


func apply() -> void:
	if player.imortal:
		allowed = false
		return
	
	player.imortal = true
	
func revert() -> void:
	player.imortal = false
