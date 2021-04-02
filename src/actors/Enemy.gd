extends Actor

onready var stomp_area: Area2D = $StompDetector;
onready var collision_shape: CollisionShape2D = $CollisionShape2D;

export var score: int = 100;

func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > stomp_area.global_position.y:
		return;
	die();

func _ready():
	set_physics_process(false);
	_velocity.x = -speed.x;

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta;
	if is_on_wall():
		_velocity.x *= -1.0;
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y;

func die() -> void:
	collision_shape.disabled = true;
	queue_free();
	PlayerData.score += score;
