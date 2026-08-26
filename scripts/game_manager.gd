extends Node

const MAX_HEALTH: int = 3

var score = 0
var health: int = MAX_HEALTH

@onready var score_label: Label = $ScoreLabel
@onready var health_label: Label = $HealthLabel

func _ready():
	reset_game()
	
func reset_game() -> void:
	print("resetting GameManager")
	health = MAX_HEALTH
	score = 0
	update_ui()

func add_point():
	score += 1
	update_ui()
	#score_label.text = "You collected " + str(score) + " coins."
	
func decrease_health():
	health -= 1
	update_ui()
	#if health <= 0:
		#get_tree().reload_current_scene()	

func update_ui() -> void:
	if score_label:
		score_label.text = "You collected " + str(score) + " coins."
	if health_label:
		health_label.text = "HP: " + str(health)
