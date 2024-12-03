class_name BasePlayerPowerUp
extends PowerUp


var player: Player


func _init() -> void:
	super._init()

func apply() -> void:
	super.apply()
	_assert_player()
	
func remove() -> void:
	super.remove()
	_assert_player()

func _assert_player() -> void:
	if not player:
		push_error('Player is not defined!')

func _on_parent_changed() -> void:
	player = parent.get_tree().get_first_node_in_group('player')
