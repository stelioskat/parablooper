extends CharacterBody2D
class_name Enemy

@export var bomb_scene : PackedScene
signal died

var max_speed = 250
var hits = 0
var fly_direction = 1

enum {FLY, HIT, FALL, AGROUND, DEAD}
var state = FLY

func _ready():
	$BombTimer.start(randf_range(0.2, 1))

func _process(delta):		
	if state == HIT and rotation < PI/5:
		rotation += fly_direction * 0.01
		if abs(rotation) >= PI/5:
			state = FALL
	
	velocity = Vector2(fly_direction, 0).rotated(rotation) * max_speed
	if is_on_floor():
		velocity = Vector2.ZERO
		if state != AGROUND:
			state = AGROUND
			$Animations/Grounding.play()
			$DeathTimer.start(0.5)			
		
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_area_entered(area):
	if hits == 0:
		$BombTimer.stop()
		died.emit()
		state = HIT
	else:
		state = DEAD
		$Animations/AirExplosion.play()
		$PlanePivot/PlaneAnimation.hide()
		$DeathTimer.start(0.5)
	hits += 1


func _on_death_timer_timeout():
	queue_free()


func _on_bomb_timer_timeout():
	var bomb = bomb_scene.instantiate()
	bomb.init(position + Vector2(0, 20), get_real_velocity())
	add_sibling(bomb)
	
func invert_direction():
	fly_direction = -fly_direction
	$PlanePivot/PlaneAnimation.scale *= Vector2(fly_direction, 1)
	$Animations/Grounding.scale *= Vector2(fly_direction, 1)
