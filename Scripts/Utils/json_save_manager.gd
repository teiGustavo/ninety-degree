class_name JSONSaveManager
extends Node


static func save(path: String, data: Variant) -> void:
	var json_string: String = JSON.stringify(data)
	
	_get_writable_file(path).store_line(json_string)

static func load(path: String, key: String = "") -> Variant:
	if not FileAccess.file_exists(path):
		return
	
	var data = JSON.parse_string(
		_get_readable_file(path).get_as_text()
	)
	
	if not data:
		return
		
	if key:
		return data.get(key)
	
	return data

static func _get_file(path: String, mode: FileAccess.ModeFlags) -> FileAccess:
	return FileAccess.open(
		path, 
		mode
	)
	
static func _get_writable_file(path: String) -> FileAccess:
	return _get_file(path, FileAccess.WRITE)

static func _get_readable_file(path: String) -> FileAccess:
	return _get_file(path, FileAccess.READ)
