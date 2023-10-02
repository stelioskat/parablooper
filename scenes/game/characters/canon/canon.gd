extends Node2D
class_name Canon

signal fire
signal died

var rot_speed = 1.4*PI 
var ration_range = PI/2.5
var _heat = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("fire") and _heat < 100:
		var bsl = $CanonPivot/BulletSpawnLocation
		bsl.rotation = $CanonPivot.rotation-PI/2
		$ShootFX.play(0.1)
		$CanonPivot/AnimationPlayer.stop(  )
		$CanonPivot/AnimationPlayer.play("canon_bouncing")
		fire.emit($CanonPivot/BulletSpawnLocation)
		
		_set_heat(_heat + 15)
		if _heat >= 100:
			$CooldownTimer.start(3)
		else:
			$CooldownTimer.start(0.5)
		
	if $CanonPivot.rotation > -ration_range && Input.is_action_pressed("left"):
		$CanonPivot.rotate(-rot_speed * delta)
	if $CanonPivot.rotation < ration_range && Input.is_action_pressed("right"):
		$CanonPivot.rotate(rot_speed * delta)


func _on_health_health_update(health):
	$HealthBar.set_health(health)
	if health <= 0:
		# game over
		died.emit()
		queue_free()


func _on_cooldown_timer_timeout():
	if _heat == 0:
		return
	if _heat >= 100:
		_set_heat(0)
	else:
		_set_heat(_heat - 10)
	if _heat < 0:  
		_set_heat(0)
		
func _set_heat(val):
	_heat = val
	$HeatHSlider.value = _heat
