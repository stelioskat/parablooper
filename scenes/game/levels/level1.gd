extends Node2D

@export var bullet_scene: PackedScene
@export var enemy_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass 


func _on_canon_fire(bullet_spawn_location):
	var bullet = bullet_scene.instantiate()
	bullet.position = bullet_spawn_location.global_position
	bullet.rotation = bullet_spawn_location.rotation
	add_child(bullet)


func _on_enemy_timer_timeout():
	$EnemyTimer.wait_time = randf_range(0.3, 1.2)
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(-65, randf_range(50,500))
	add_child(enemy)
