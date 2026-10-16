extends Node

var score : int = 0

var scene_to_load : PackedScene = preload("uid://c7hck0urcu2cc")

func game_over():
	get_tree().reload_current_scene()
