class_name Enemy
extends BaseCharacter


const BASE_SPEED: float = Player.BASE_SPEED

@export var initial_direction: Vector2 = Vector2.DOWN

@onready var shape: Shape2D = $CollisionShape2D.shape


func _init() -> void:
	if speed_is_empty():
		speed = BASE_SPEED

func _ready() -> void:
	super._ready()
	
	collision_shape = $CollisionShape2D
	
	add_to_group("enemy")
	
	if shape is RectangleShape2D:
		shape = shape as RectangleShape2D
		
		var distance_from_middle: Vector2 = Vector2(
			shape.extents.x, 
			shape.extents.y
		) * scale
		
		screen_limits.safety_margin += Vector2(distance_from_middle.x, 0)
		screen_limits.screen_min_size.y = -distance_from_middle.y
	
	if not position.y:
		position.y = screen_limits.get_min_y_position()

	clamp_position()
	
	direction = initial_direction

func _physics_process(delta: float) -> void:
	velocity = direction * speed * delta
	
	move_based_on_velocity()

func clamp_position() -> void:
	position.x = clampf(position.x, screen_limits.get_min_x_position(), screen_limits.get_max_x_position())

func _on_collided(collider: Object) -> void:
	match collider.get_groups():
		["player"]:
			collider = collider as Player
			collider.die()
			fade_queue_free()
