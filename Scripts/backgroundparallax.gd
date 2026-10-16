extends Node2D

var parallax : float = 0.7
@onready var player : CharacterBody2D = %Player

func _process(delta: float) -> void:
	global_position = player.global_position * parallax
