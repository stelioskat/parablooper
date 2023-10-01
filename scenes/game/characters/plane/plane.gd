extends CharacterBody2D
class_name Enemy

@export var bomb_scene : PackedScene
signal died

var max_speed = 250
var _fly_direction = 1

enum {FLY, HIT, FALL, AGROUND, DEAD}
var _state = FLY


func _ready():
	$BombTimer.start(randf_range(0.8, 2))
	$PropSound.play()


func _process(delta):		
	if _state == HIT and rotation < PI/5:
		rotation += _fly_direction * 0.01
		if abs(rotation) >= PI/5:
			_state = FALL
	
	velocity = Vector2(_fly_direction, 0).rotated(rotation) * max_speed
	if is_on_floor():
		velocity = Vector2.ZERO
		if _state != AGROUND:
			_state = AGROUND
			$Animations/Grounding.play()
			$DeathTimer.start(0.5)			
		
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_area_entered(area):
	# TODO validate if area is a bullet
	$Health.damage(50)
#	if _state != DEAD:
		


func _on_death_timer_timeout():
	queue_free()


func _on_bomb_timer_timeout():
	var bomb = bomb_scene.instantiate()
	bomb.init(position + Vector2(0, 20), get_real_velocity())
	
	add_sibling(bomb)


func invert_direction():
	_fly_direction = -_fly_direction
	$PlanePivot/PlaneAnimation.scale *= Vector2(_fly_direction, 1)
	$Animations/Grounding.scale *= Vector2(_fly_direction, 1)


func _on_health_health_update(health):
	if health > 0 && _state != HIT:
		$BombTimer.stop()
		_state = HIT
	elif health == 0 and _state != DEAD:
		_state = DEAD
		died.emit()
		$ExplodeFX.play()
		$Animations/AirExplosion.play()
		$PlanePivot/PlaneAnimation.hide()
		$DeathTimer.start(1.5)
