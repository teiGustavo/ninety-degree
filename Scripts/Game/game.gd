@tool
class_name Game
extends GameToolScript


signal player_collided_with_edge

const FOOD: PackedScene = preload("res://Prefabs/Characters/Food/food.tscn")
const UP_ARROW: PackedScene = preload("res://Prefabs/Utils/up_arrow.tscn")
const BASE_POWER_UP: PackedScene = preload("res://Prefabs/PowerUps/base_power_up.tscn")

@export_group("Food Spawn")
@export_range(0, 500, 0.1) var min_distance_from_player_to_food: float = 150
@export_range(1, 10) var max_attempts_to_spawn_food: int = 5
@export_group("Debug")
@export var show_fps: bool = false:
	set = _set_show_fps

var food: Food
var active_powerups: Array[PowerUp] = []

@onready var edges: Node2D = $CollisionEdges
@onready var player: CharacterBody2D = $Player
@onready var scoreboard: CanvasLayer = $Scoreboard
@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer
@onready var power_up_spawn_timer: Timer = $PowerUpSpawnTimer
@onready var fps_counter: FpsCounter = $FpsCounter
@onready var power_ups_duration_display: PowerUpsDurationDisplay = \
	$PowerUpsDurationDisplay
@onready var cheat_menu: CheatMenu = $CheatMenu


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
		
		Cheats.cheat_toggled.connect(_on_cheat_toggled)
		
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
	if not power_ups:
		return
	
	var power_up: BasePowerUp = BASE_POWER_UP.instantiate()
	
	power_up.strategy = power_ups.pick_random()
			
	while power_up.position == Vector2.ZERO \
		or power_up.position == food.position:
		power_up.position = power_up.boundaries.spawn.get_random()
		
	power_up.collected.connect(add_power_up.bind(power_up.strategy))
		
	add_child(power_up)

func add_power_up(strategy: PowerUp) -> void:	
	if not strategy.can_applied():
		return
		
	if strategy not in active_powerups:
		active_powerups.append(strategy)
	
	apply_power_up(strategy)

func generate_timer_group_name_by_strategy(strategy: PowerUp) -> StringName:
	return StringName(strategy.name + "Timer")

func apply_power_up(strategy: PowerUp) -> void:
	var timer_group: StringName = generate_timer_group_name_by_strategy(
		strategy
	)
	var timer: Timer = get_tree().get_first_node_in_group(timer_group)
	
	if not timer:
		timer = Timer.new()
		timer.add_to_group(timer_group)
		timer.one_shot = true
		timer.timeout.connect(remove_power_up.bind(strategy))
		
		add_child(timer)
		power_ups_duration_display.add_power_up(timer_group, strategy.texture)
	
	timer.wait_time = strategy.duration_in_seconds + timer.time_left
	
	timer.start()
	strategy.apply()
	
func remove_power_up(strategy: PowerUp) -> void:
	if strategy not in active_powerups:
		return
		
	strategy.remove()
	active_powerups.erase(strategy)

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

func _on_cheat_toggled(cheat: Cheats.Cheat, toggled_on: bool) -> void:
	match cheat:
		Cheats.Cheat.NOT_SPAWN_ENEMIES:
			not_spawn_enemies = toggled_on
		Cheats.Cheat.SPAWN_POWER_UP:
			spawn_power_up()
