extends CanvasLayer


@onready var anim_player: AnimationPlayer = $Control/AnimationPlayer



func change_scene_to_packed(packed_scene: PackedScene) -> void:
	await _trans_hide()
	if is_inside_tree():
		get_tree().change_scene_to_packed(packed_scene)
	await _trans_show()

func change_scene_to_file(file_path: String) -> void:
	await _trans_hide()
	if is_inside_tree():
		get_tree().change_scene_to_file(file_path)
	await _trans_show()


func _trans_hide() -> void:
	anim_player.play("trans_hide")
	await anim_player.animation_finished

func _trans_show() -> void:
	anim_player.play("trans_show")
	await anim_player.animation_finished
