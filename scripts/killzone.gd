extends Area2D

@export var is_instant_kill: bool = false
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" or body.is_in_group("player"):
		# Skip damage if player is currently rolling
		if "is_rolling" in body and body.is_rolling:
			return
	
		if is_instant_kill:
			trigger_death(body)
		else:
			print("collision")
			if GameManager:
				GameManager.decrease_health()
				# If health drops to 0 or below, trigger death
				if GameManager.health <= 0:
					trigger_death(body)
			else:
				print("game manager is null")

func trigger_death(body: Node2D) -> void:
	print("You died")
	Engine.time_scale = 0.5
	if body.has_node("CollisionShape2D"):
		body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
