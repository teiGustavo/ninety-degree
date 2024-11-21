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
	
	screen_limits.safety_margin.top = 0
	screen_limits.safety_margin.bottom = 0
	
	screen_limits.screen_min_size.y = \
		-collision_geometry.distances_from_middle.top
	
	if not position.y:
		position.y = screen_limits.get_min_y_position()

	clamp_position()
	
func _physics_process(delta: float) -> void:
	velocity = direction * speed * delta
	
	move_based_on_velocity()

func clamp_position() -> void:
	position.x = clampf(
		position.x, 
		screen_limits.get_min_x_position(), 
		screen_limits.get_max_x_position()
	)

func _on_collided(collider: Object) -> void:
	match collider.get_groups():
		["player"]:
			collider = collider as Player
			collider.die()
			fade_queue_free()
