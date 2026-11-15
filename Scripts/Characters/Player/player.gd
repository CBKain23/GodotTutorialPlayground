extends CharacterBody2D

signal OnUpdateHealth(health : int)
signal OnUpdateScore(score : int)

##The Player's Top Movement Speed
@export var move_speed : float = 500.0

##How fast the player reaches top speeds.
@export var acceleration : float = 100.0

##How much the player will slow down whenever they're not accelerating.
@export var braking : float = 10.0

@export var gravity : float = 600.0

@export var jump_force : float = 400.0

var health : int = GameManager.playerHealth

var move_input : float

@onready var sprite : AnimatedSprite2D = %PlayerSprite

@onready var audio : AudioStreamPlayer = %AudioStreamPlayer

func _process(delta: float) -> void:
	
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0
	
	_manage_animation()



func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_input = Input.get_axis("move_left", "move_right")
	
	#velocity.x = move_input * move_speed
	if move_input != 0:
		velocity.x = lerp(velocity.x, (move_input * move_speed), (acceleration * delta))
	else:
		velocity.x = lerp(velocity.x, 0.0, (braking * delta))
	
	jump()
	
	move_and_slide()

func _ready() -> void:
	GameManager.setPlayer(self)

func _manage_animation():
	
	if not is_on_floor():
		sprite.play("jump")
	elif move_input != 0:
		sprite.play("walk")
	else:
		sprite.play("idle")


func take_damage(amount : int):
	health -= amount
	OnUpdateHealth.emit(health)
	_damage_flash()
	
	
	%AudioStreamPlayer.stream = Audio.take_damage_sfx
	%AudioStreamPlayer.play()
	
	if health <= 0:
		GameManager.call_deferred("game_over")

func jump():
		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.y = -jump_force

func increase_score(amount: int):
	print("increase score by " + str(amount))
	GameManager.score += amount
	OnUpdateScore.emit(GameManager.score)
	%AudioStreamPlayer.stream = Audio.coin_sfx
	%AudioStreamPlayer.play()


func _damage_flash():
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.05).timeout
	sprite.modulate = Color.WHITE
