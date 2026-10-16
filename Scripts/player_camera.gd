extends Camera2D

var intensity : float = 0.0

@onready var camera : Camera2D = %PlayerCamera

@onready var current_offset : float = camera.offset.y


func _ready():
	get_parent().OnUpdateHealth.connect(_damage_shake)
	
	

func _damage_shake(health: int):
	intensity = 15.0


func _process(delta: float) -> void:
	if intensity > 0:
		intensity = lerpf(intensity, 0, delta * 5)
		offset = _get_random_offset()


func _get_random_offset() -> Vector2:
	var x = randf_range(-intensity, intensity)
	var y = randf_range(-intensity, intensity)
	
	return Vector2(x,(current_offset + y))
