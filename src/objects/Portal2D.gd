tool
extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer;
export var next_scene: PackedScene;

func _get_configuration_warning() -> String:
	return "The Next Scene property can't be empty." if not next_scene else "";

func _on_body_entered(body: Node) -> void:
	teleport();

func teleport() -> void:
	anim_player.play("fade_in");
	# Wait for player to emit signal
	yield(anim_player, "animation_finished");
	# Get scene tree and switch to next scene
	get_tree().change_scene_to(next_scene);
