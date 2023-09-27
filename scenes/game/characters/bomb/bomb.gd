extends RigidBody2D

signal exploded
var is_exploded = false


func _ready():
	set_freeze_mode(FREEZE_MODE_KINEMATIC)
#	init(Vector2.ZERO, Vector2(400,0))


func init(start_position : Vector2, start_velocity : Vector2):
	position = start_position
	set_axis_velocity(start_velocity)


func _on_body_entered(body):
	explode()

func _on_area_2d_area_entered(area):
	explode()

func explode():
	if is_exploded:
		return
		
	exploded.emit()
	call_deferred("set_freeze_enabled", true)
	call_deferred("set_axis_velocity", Vector2.ZERO)
	$BombSprite.visible = false
	$ExplosionAnimatedSprite.play()
	$UnspawnTimer.start()


func _on_unspawn_timer_timeout():
	queue_free()



