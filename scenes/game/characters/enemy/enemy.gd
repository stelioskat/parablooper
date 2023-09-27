extends CharacterBody2D
class_name Enemy

signal died

var max_speed = 400
var hits = 0
var aground = false

func _process(delta):		
	velocity = Vector2(1, 0).rotated(rotation) * max_speed
	if is_on_floor():
		velocity = Vector2.ZERO
		if not aground:
			aground = true
			$ExplosionAnimation.play()
			$DeathTimer.start(0.8)			
		
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_2d_area_entered(area):
	if hits == 0:
		died.emit()
		rotation = PI/5 + randf_range(-0.2,0.2)		
	hits += 1

func _on_death_timer_timeout():
	queue_free()
