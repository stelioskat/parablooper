extends Node2D
class_name Canon

signal fire

var rot_speed = 1.8*PI 
var ration_range = PI/2.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("fire"):
		var bsl = $CanonPivot/BulletSpawnLocation
		bsl.rotation = $CanonPivot.rotation-PI/2
		$ShootFX.play(0.1)
		fire.emit($CanonPivot/BulletSpawnLocation)
		
	if $CanonPivot.rotation > -ration_range && Input.is_action_pressed("left"):
		$CanonPivot.rotate(-rot_speed * delta)
	if $CanonPivot.rotation < ration_range && Input.is_action_pressed("right"):
		$CanonPivot.rotate(rot_speed * delta)


func _on_health_health_update(health):
	$HealthBar.set_health(health)
	if health <= 0:
		# game over
		queue_free()
