extends Node

var score = 0
var health = 3

@onready var score_label: Label = $ScoreLabel

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."
	
func decrease_health():
	if health > 0:
		health -= 1
