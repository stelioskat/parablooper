extends RigidBody2D

signal exploded
var is_exploded = false


func _ready():
	set_freeze_mode(FREEZE_MODE_KINEMATIC)


func init(start_velocity : Vector2):
	set_axis_velocity(start_velocity)


func _on_body_entered(body):
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
