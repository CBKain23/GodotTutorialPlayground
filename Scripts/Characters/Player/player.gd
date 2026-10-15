extends CharacterBody2D


##The Player's Top Movement Speed
@export var move_speed : float = 500.0

##How fast the player reaches top speeds.
@export var acceleration : float = 100.0

##How much the player will slow down whenever they're not accelerating.
@export var braking : float = 10.0

@export var gravity : float = 600.0

@export var jump_force : float = 400.0

@export var health : int = 3

var move_input : float

@onready var sprite : AnimatedSprite2D = %PlayerSprite

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
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	move_and_slide()


func _manage_animation():
	
	if not is_on_floor():
		sprite.play("jump")
	elif move_input != 0:
		sprite.play("walk")
	else:
		sprite.play("idle")


func take_damage(amount : int):
	health -= amount
	
	if health <= 0:
		call_deferred("game_over")

func game_over():
	get_tree().reload_current_scene()
