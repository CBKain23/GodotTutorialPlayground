extends CanvasLayer

@onready var health_container : HBoxContainer = %HealthContainer
var hearts : Array = []

@onready var heart : PackedScene = preload("uid://c47wnv5n1ikj")

@onready var score_text : Label = %ScoreText

@onready var player = get_parent()

func _ready() -> void:
	
	setPlayerHealth()
	
	player.OnUpdateHealth.connect(_update_hearts)
	player.OnUpdateScore.connect(_update_score)
	
	_update_hearts(player.health)
	_update_score(GameManager.score)

func _update_hearts(health: int):
	
	for i in len(hearts):
		hearts[i].visible = i < health
	
	

func _update_score(score: int):
	score_text.text = "Score: " + str(score)


func setPlayerHealth():
	hearts.resize(player.health)
	
	for i in len(hearts):
		health_container.add_child(heart.instantiate())
	
	hearts = health_container.get_children()
