extends Node

@export var body: CharacterBody2D
@onready var gravity: float = GameManager.globalGravity


func _physics_process(delta: float) -> void:
	applyGravity(delta)


func applyGravity(delta: float):
	if not body.is_on_floor():
		body.velocity.y += gravity * delta
