extends RigidBody2D

var speed = 400
var lift  = 493
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	linear_velocity = Vector2(1, 0) * speed
#	$Plane.apply_central_force(Vector2(0,-lift))

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
