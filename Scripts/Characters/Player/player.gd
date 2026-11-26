extends CharacterBody2D

signal OnUpdateHealth(health: int)
signal OnUpdateScore(score: int)

##The Player's Top Movement Speed
@export var move_speed: float = 500.0

##How fast the player reaches top speeds.
@export var acceleration: float = 100.0

##How much the player will slow down whenever they're not accelerating.
@export var braking: float = 10.0

@export var gravity: float = 600.0

@export var jump_force: float = 500.0

var double_jump_force: float = jump_force * 0.8

var double_jump_limit: int = 1

var jump_count: int = 0

var health: int = GameManager.playerHealth

var move_input: float

@onready var sprite: AnimatedSprite2D = %PlayerSprite

@onready var audio: AudioStreamPlayer = %AudioStreamPlayer


func _process(delta: float) -> void:
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0
	
	manage_animation()


func _physics_process(delta: float) -> void:
	move_input = Input.get_axis("move_left", "move_right")

	if move_input != 0:
		velocity.x = lerp(velocity.x, (move_input * move_speed), (acceleration * delta))
	else:
		velocity.x = lerp(velocity.x, 0.0, (braking * delta))
	
	jump()
	resetJumpCount()
	
	move_and_slide()


func _ready() -> void:
	GameManager.setPlayer(self)


func manage_animation():
	if not is_on_floor():
		sprite.play("jump")
	elif move_input != 0:
		sprite.play("walk")
	else:
		sprite.play("idle")


func take_damage(amount: int):
	health -= amount
	OnUpdateHealth.emit(health)
	damage_flash()
	playAudio(Audio.take_damage_sfx, Audio.damageVol)
	if health <= 0:
		GameManager.call_deferred("game_over")


func increaseJumpCount():
	jump_count += 1

func resetJumpCount():
	if is_on_floor():
		jump_count = 0

func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
		jump_count += 1

	if (Input.is_action_just_pressed("jump") and not is_on_floor() and not jump_count >= double_jump_limit):
		velocity.y = -double_jump_force
		playAudio(Audio.doubleJumpSFX, Audio.jumpVol)
		jump_count += 1

func increase_score(amount: int):
	print("increase score by " + str(amount))
	GameManager.score += amount
	OnUpdateScore.emit(GameManager.score)
	playAudio(Audio.coin_sfx, Audio.coinVol)


func playAudio(stream: AudioStream, volume: float):
	%AudioStreamPlayer.stream = stream
	%AudioStreamPlayer.volume_db = volume
	%AudioStreamPlayer.play()


func damage_flash():
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.05).timeout
	sprite.modulate = Color.WHITE
