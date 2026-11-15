extends Node


var take_damage_sfx : AudioStream = preload("uid://dpfxt7ik4y8g4")
var coin_sfx : AudioStream = preload("uid://fafdykrv3j1p")
var doubleJumpSFX : AudioStream = preload("uid://yup4x612dvi")

@onready var audioPlayer : AudioStreamPlayer 

func _ready() -> void:
	pass
	#audioPlayer.max_polyphony = 15

#Not making any sounds!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
func play_sound(sound: AudioStream):
	
	audioPlayer.stream = sound
	audioPlayer.play()
