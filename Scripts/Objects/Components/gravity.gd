extends Node

## The body of the character
@export var body: CharacterBody2D

## The weight of the character
@export_range(1.0, 1.9) var weight : float

## The Global gravity of the game
@onready var gravity: float = GameManager.globalGravity

func _physics_process(delta: float) -> void:
	if not body.is_on_floor():
		body.velocity.y += (gravity * weight) * delta
