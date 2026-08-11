extends Node

const VERSION_PATH = "res://version.json"
var current_version: Dictionary = {}

func _ready() -> void:
	current_version = load_version_file()
	print("Game initialized at build version: ", current_version.get("string", "0.0.0.0"))

func load_version_file() -> Dictionary:
	if FileAccess.file_exists(VERSION_PATH):
		var file := FileAccess.open(VERSION_PATH, FileAccess.READ)
		var json_string := file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var error := json.parse(json_string)
		if error == OK:
			return json.data as Dictionary
			
	return {"major": 1, "minor": 0, "patch": 0, "build": 0, "string": "1.0.0.0"}
