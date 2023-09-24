extends CharacterBody2D

var max_speed = 400
var lift  = 493
var hits = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):		
	velocity = Vector2(1, 0).rotated(rotation) * max_speed
	if is_on_floor():
		velocity = Vector2.ZERO
		
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_2d_area_entered(area):
	if hits == 0:
		rotation = PI/5 + randf_range(-0.2,0.2)		
	hits += 1

func _on_death_timer_timeout():
	queue_free()

func _on_area_2d_body_entered(body):
	if is_on_floor():
		$ExplosionAnimation.play()
		$DeathTimer.start(0.8)
