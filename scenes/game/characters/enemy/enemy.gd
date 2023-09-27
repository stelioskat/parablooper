extends CharacterBody2D
class_name Enemy

@export var bomb_scene : PackedScene
signal died

var max_speed = 400
var hits = 0
var aground = false

func _ready():
	$BombTimer.start(0.5 + randf_range(-0.3, 1))

func _process(delta):		
	velocity = Vector2(1, 0).rotated(rotation) * max_speed
	if is_on_floor():
		velocity = Vector2.ZERO
		if not aground:
			aground = true
			$Animations/Grounding.play()
			$DeathTimer.start(0.8)			
		
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_2d_area_entered(area):
	if hits == 0:
		$BombTimer.stop()
		died.emit()
		rotation = PI/5 + randf_range(-0.2,0.2)		
	else:
		$Animations/AirExplosion.play()
		$PlanePivot/PlaneAnimation.hide()
		$DeathTimer.start(0.3)
	hits += 1

func _on_death_timer_timeout():
	queue_free()


func _on_bomb_timer_timeout():
	var bomb = bomb_scene.instantiate()
	print(position)
	print(get_real_velocity())
	bomb.init(position + Vector2(0, 20), get_real_velocity())
	add_sibling(bomb)
