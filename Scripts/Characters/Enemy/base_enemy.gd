class_name BaseEnemy
extends BaseCharacter


const BASE_SPEED: float = Player.BASE_SPEED

@export var initial_direction: Vector2 = Vector2.DOWN


func _init() -> void:
	if speed_is_empty():
		speed = BASE_SPEED

func _ready() -> void:
	super._ready()
	
	add_to_group("enemy")
	
	direction = initial_direction
	
	boundaries.spawn.safety_margin.minimum.y = \
		-collision_geometry.distances_from_middle.minimum.y
	
	if not position.y:
		position.y = boundaries.spawn.get_min_y()

	clamp_position()

func clamp_position() -> void:
	position.x = clampf(
		position.x, 
		boundaries.movement.get_min_x(), 
		boundaries.movement.get_max_x()
	)

func _on_collided(collider: Object) -> void:
	if collider.is_in_group("player"):
		collider = collider as Player
		collider.die()
		fade_queue_free()
