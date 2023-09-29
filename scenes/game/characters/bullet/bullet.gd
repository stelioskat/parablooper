extends Node2D
class_name Bullet

var speed = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2(speed, 0.0).rotated(rotation)
	position += velocity

func _on_area_2d_area_entered(area):
	queue_free()
