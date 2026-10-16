extends Node


var take_damage_sfx : AudioStream = preload("uid://dpfxt7ik4y8g4")
var coin_sfx : AudioStream = preload("uid://fafdykrv3j1p")

func _ready() -> void:
	pass

func play_sound(sound: AudioStream, player: AudioStreamPlayer):
	player.stream = sound
	player.play()
