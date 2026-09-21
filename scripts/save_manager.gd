extends Node

const SAVE_PATH = "user://save.cfg"
var start_level: int = 1
var play_intro: bool = false

func save_level(level: int) -> void:
	var cfg = ConfigFile.new()
	cfg.set_value("progress", "level", level)
	var err = cfg.save(SAVE_PATH)
	print("SAVE: level ", level, " | error code ", err, " | ", ProjectSettings.globalize_path(SAVE_PATH))

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func load_level() -> int:
	var cfg = ConfigFile.new()
	if cfg.load(SAVE_PATH) != OK:
		return 1
	return cfg.get_value("progress", "level", 1)
