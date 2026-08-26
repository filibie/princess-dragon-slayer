extends Area2D

@export var is_instant_kill: bool = false
@onready var timer: Timer = $Timer

const HIT_KNOCKBACK = 200.0
const HIT_UPWARD_FORCE = -200.0

func _on_body_entered(body: Node2D) -> void:
	if not (body.name == "Player" or body.is_in_group("player")):
		print("debug1")
		return
	
	# Skip damage if player is rolling
	if "is_rolling" in body and body.is_rolling:
		print("debug2")
		return
	
	if is_instant_kill:
		print("debug3")
		trigger_death(body)
		return
	
	if GameManager:
		# Don't re-apply hit if player is already in hit state
		if "is_hit" in body and body.is_hit:
			print("debug4")
			return
			
		GameManager.decrease_health()
		
		# Trigger hit state on player (handles knockback + animation safety)
		if body.has_method("take_hit"):
			print("body has method take_hit")
			var hit_dir = sign(body.global_position.x - global_position.x)
			if hit_dir == 0:
				hit_dir = 1.0
			body.take_hit(Vector2(hit_dir * HIT_KNOCKBACK, HIT_UPWARD_FORCE))
	
		if GameManager.health <= 0:
			trigger_death(body)

func trigger_death(body: Node2D) -> void:
	print("You died")
	Engine.time_scale = 0.5
	if body.has_node("CollisionShape2D"):
		body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	if GameManager:
		GameManager.reset_game()
	get_tree().reload_current_scene()
