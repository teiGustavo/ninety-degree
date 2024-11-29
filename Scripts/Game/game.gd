@tool
class_name Game
extends BaseGame


signal player_collided_with_edge

const FOOD: PackedScene = preload("res://Prefabs/Characters/Food/food.tscn")
const UP_ARROW: PackedScene = preload("res://Prefabs/Utils/up_arrow.tscn")

@export_group("Food Spawn")
@export_range(0, 500, 0.1) var min_distance_from_player_to_food: float = 150
@export_range(1, 10) var max_attempts_to_spawn_food: int = 5
@export_group("Debug")
@export var show_fps: bool = false:
	set = _set_show_fps

var food: Food

@onready var edges: Node2D = $CollisionEdges
@onready var player: CharacterBody2D = $Player
@onready var scoreboard: CanvasLayer = $Scoreboard
@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer
@onready var power_up_spawn_timer: Timer = $PowerUpSpawnTimer
@onready var fps_counter: FpsCounter = $FpsCounter


func _ready() -> void:
	if not Engine.is_editor_hint():
		super._ready()
		
		for edge in edges.get_children():
			edge.body_entered.connect(_on_edge_body_entered)
			
		player_collided_with_edge.connect(player._on_collided_with_edge)
		player.food_collected.connect(_on_player_food_collected)
		player.died.connect(_on_player_died)
		difficulty_changed.connect(_on_difficulty_changed)
		locked_difficulty_changed.connect(_on_difficulty_changed)
		enemy_spawn_timer.timeout.connect(_on_enemy_spawn_timer_timeout)
		power_up_spawn_timer.timeout.connect(_on_power_up_spawn_timer_timeout)
		spawn_random_powerup.connect(spawn_power_up)
		
		fps_counter.visible = show_fps
		
		update_scoreboard()
		spawn_food()

func set_food_movement_and_speed() -> void:
	food.movement_mode = current_difficulty.food_movement_mode
	food.speed = food.BASE_SPEED \
		+ (food.BASE_SPEED * current_difficulty.speed_increase)

func spawn_food() -> void:
	var spawn_position: Vector2 = Vector2.ZERO
	
	food = FOOD.instantiate()
	
	for attempt in range(max_attempts_to_spawn_food):
		spawn_position = food.boundaries.spawn.get_random()
		
		if spawn_position.distance_to(player.position) \
			>= min_distance_from_player_to_food:
			break
		
	food.position = spawn_position
	set_food_movement_and_speed()
	
	food.collected.connect(spawn_food)
	
	add_child.call_deferred(food)

func spawn_enemy() -> void:
	var enemy_variations: Array[PackedScene] = \
		current_difficulty.enemy_variations
	
	if not enemy_variations:
		return
	
	var enemy: BaseEnemy = enemy_variations.pick_random().instantiate()
	enemy.position.x = enemy.boundaries.spawn.get_random_x()
	
	var arrow: UpArrow = UP_ARROW.instantiate()
	arrow.position.x = enemy.position.x
	
	var timer: Timer = Timer.new()
	timer.wait_time = 1
	
	timer.timeout.connect(
		func () -> void:
			add_child(enemy)
			arrow.queue_free()
			timer.queue_free()
	)
	add_child(timer)
	
	timer.start()
	add_child(arrow)

func spawn_power_up() -> void:
	var power_up_variations: Array[PackedScene] = Array(
		power_ups.map(
			func (p: PowerUp) -> PackedScene: return p.scene
		),
		TYPE_OBJECT,
		"PackedScene",
		null
	)
	
	if not power_up_variations:
		return
	
	var power_up: BasePowerUp = power_up_variations.pick_random().instantiate()
	
	while power_up.position == Vector2.ZERO \
		or power_up.position == food.position:
		power_up.position = power_up.boundaries.spawn.get_random()
	
	add_child(power_up)

func update_scoreboard() -> void:
	scoreboard.set_score(str(GameState.score))

func _on_edge_body_entered(body) -> void:
	if body.is_in_group("player"):
		player_collided_with_edge.emit()

func _on_player_food_collected() -> void:
	GameState.increase_score()
	update_scoreboard()
	update_difficulty()
	
func _on_player_died() -> void:
	GameState.update_best_score()
	GameState.save_best_score()
	
	if get_tree():
		get_tree().change_scene_to_file("res://Scenes/game_over_menu.tscn")
	
func _on_difficulty_changed() -> void:
	if food:
		set_food_movement_and_speed()

func _on_enemy_spawn_timer_timeout() -> void:
	if not not_spawn_enemies:
		spawn_enemy()

func _on_power_up_spawn_timer_timeout() -> void:
	if not not_spawn_power_ups:
		spawn_power_up()

func _set_show_fps(value: bool) -> void:
	show_fps = value
	
	if fps_counter:
		fps_counter.visible = show_fps
