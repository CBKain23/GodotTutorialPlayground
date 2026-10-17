extends Node


var take_damage_sfx : AudioStream = preload("uid://dpfxt7ik4y8g4")
var coin_sfx : AudioStream = preload("uid://fafdykrv3j1p")

@onready var audioPlayer : AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	pass

#Not making any sounds!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
func play_sound(sound: AudioStream):
	
	audioPlayer.stream = sound
	audioPlayer.play()
