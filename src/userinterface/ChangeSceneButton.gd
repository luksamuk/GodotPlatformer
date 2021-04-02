tool
extends Button

export(String, FILE) var next_scene_path: String;

func _get_configuration_warning() -> String:
	return "The next scene path must be specified." if not next_scene_path else "";

func _on_button_up() -> void:
	get_tree().change_scene(next_scene_path);
