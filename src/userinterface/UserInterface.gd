extends Control

onready var scene_tree:    SceneTree = get_tree();
onready var pause_overlay: ColorRect = $PauseOverlay;
onready var score:         Label     = $Label
onready var pause_title:   Label     = $PauseOverlay/Title;

var paused: bool = false setget set_paused;
var player_died: bool = false;

func _ready() -> void:
	PlayerData.connect("score_updated", self, "update_interface");
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died");
	update_interface();

func _on_PlayerData_player_died() -> void:
	self.paused = true;
	player_died = true;
	pause_title.text = "You died!";

func _unhandled_input(event: InputEvent) -> void:
	if not player_died and event.is_action_pressed("pause"):
		self.paused = not paused;          # Explicitly call setter
		scene_tree.set_input_as_handled(); # Ignore rest of input

func update_interface() -> void:
	score.text = "Score: %s" % PlayerData.score;

func set_paused(value: bool) -> void:
	paused                = value;
	scene_tree.paused     = value;
	pause_overlay.visible = value;
