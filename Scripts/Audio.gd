extends Node


var take_damage_sfx : AudioStream = preload("uid://dpfxt7ik4y8g4")
var coin_sfx : AudioStream = preload("uid://fafdykrv3j1p")
var doubleJumpSFX : AudioStream = preload("uid://yup4x612dvi")

var coinVol : float = -15.0
var damageVol : float = 0.0
var jumpVol : float = 0.0

@onready var audioPlayer : AudioStreamPlayer

func _ready() -> void:
	pass

#Not making any sounds!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
func play_sound(sound: AudioStream):
	
	audioPlayer.stream = sound
	audioPlayer.play()
