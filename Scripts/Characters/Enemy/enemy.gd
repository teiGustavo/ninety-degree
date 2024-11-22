class_name Enemy
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
	
	boundaries.spawn.min.top = -collision_geometry.distances_from_middle.top
	
	if not position.y:
		position.y = boundaries.spawn.get_min_y()

	clamp_position()
	
func _physics_process(delta: float) -> void:
	velocity = direction * speed * delta
	
	move_based_on_velocity()

func clamp_position() -> void:
	position.x = clampf(
		position.x, 
		boundaries.movement.get_min_x(), 
		boundaries.movement.get_max_x()
	)

func _on_collided(collider: Object) -> void:
	match collider.get_groups():
		["player"]:
			collider = collider as Player
			collider.die()
			fade_queue_free()
