class_name DataManager
extends Node


static func get_from_json(file_path: String) -> Dictionary:
	if not FileAccess.file_exists(file_path):
		push_error("File not exists!")
		
	var file: FileAccess = FileAccess.open(file_path, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	
	if not data or data is not Dictionary:
		push_error("Error on reading file!")
	
	return data
