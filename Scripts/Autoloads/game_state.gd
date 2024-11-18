extends Node


var score: int = 0
var best_score: int = 0


func _ready() -> void:
	load_best_score()

func increase_score(points: int = 1) -> void:
	score += points

func reset_score() -> void:
	score = 0

func update_best_score() -> void:
	if score > best_score:
		best_score = score

func save_best_score() -> void:
	var save_file: FileAccess = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string: String = JSON.stringify({"best_score": best_score})
	
	save_file.store_line(json_string)

func load_best_score() -> void:
	if not FileAccess.file_exists("user://savegame.save"):
		return
	
	var save_file: FileAccess = FileAccess.open("user://savegame.save", FileAccess.READ)
	var data = JSON.parse_string(save_file.get_as_text())
	
	if not data:
		return
	
	best_score = data["best_score"]
