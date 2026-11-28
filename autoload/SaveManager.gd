extends Node

const SAVE_PATH: String = "user://saves/"
const FILE_END: String = ".res"


func _get_save_path(save_name: String) -> String:
	var safe_name := save_name.validate_filename()
	return SAVE_PATH.path_join(safe_name + FILE_END)

func save_game(save_name: String) -> void:
	if not DirAccess.dir_exists_absolute(SAVE_PATH):
		DirAccess.make_dir_recursive_absolute(SAVE_PATH)
	
	var data: SaveData = SaveData.new()
	data.dna = GameManager.dna
	
	
	var path := _get_save_path(save_name)
	var err := ResourceSaver.save(data, path)
	if err != OK:
		push_error("Failed to save '%s': %s" % [save_name, err])

func load_game(save_name: String) -> bool:
	var path := _get_save_path(save_name)
	if not ResourceLoader.exists(path):
		push_warning("Save file not found: " + path)
		return false
	
	var data := ResourceLoader.load(path) as SaveData
	if data:
		GameManager.dna = data.dna
		
		return true
	return false

func get_all_saves() -> Array[String]:
	var saves: Array[String] = []
	if not DirAccess.dir_exists_absolute(SAVE_PATH):
		return saves
	
	var dir := DirAccess.open(SAVE_PATH)
	if dir:
		for file_name in dir.get_files():
			if file_name.ends_with(FILE_END):
				saves.append(file_name.trim_suffix(FILE_END))
	return saves

func delete_save(save_name: String) -> void:
	var path := _get_save_path(save_name)
	if FileAccess.file_exists(path):
		DirAccess.remove_absolute(path)
