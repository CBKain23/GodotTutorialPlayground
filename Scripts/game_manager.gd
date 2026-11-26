extends Node

var score: int = 0

var scene_to_load: PackedScene = preload("uid://c7hck0urcu2cc")

var player: CharacterBody2D

var playerHealth: int = 5

var globalGravity: float = 600


func game_over():
	get_tree().reload_current_scene()


func setPlayer(char: CharacterBody2D):
	player = char


func getPlayer():
	return player
