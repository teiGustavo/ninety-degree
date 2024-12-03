class_name InvincibilityPowerUp
extends BasePlayerPowerUp


const CHEAT: Cheats.Cheat = Cheats.Cheat.IMORTAL


func can_applied() -> bool:
	return true if not Cheats.is_enabled(CHEAT) else false

func can_removed() -> bool:
	return can_applied()

func apply() -> void:
	super.apply()
	
	player.imortal = true
	Cheats.block_cheat(CHEAT)

func remove() -> void:
	super.remove()
	
	player.imortal = false
	Cheats.unblock_cheat(CHEAT)
