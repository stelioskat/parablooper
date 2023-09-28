extends Node2D

signal scored

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
	$EnemySpawnTimer.wait_time = randf_range(0.3, 1.2)
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(-65, randf_range(50,500))
	enemy.died.connect(_on_enemy_died)
	add_child(enemy)

func _on_enemy_died():
	# for now we always give 1 point for each kilö
	scored.emit(1)
	pass
	
func apply_damage(damage_origin : Vector2):
	# later we could use player/enemy stats or a damage/attack object :thinking:
	var max_damage = 10
	var range = 60
	
	var nodes = get_tree().get_nodes_in_group("has_health")
	for node in nodes:
		var dist = node.position.distance_to(damage_origin)
		var target_damage = 0
		if dist <= range:
			target_damage = (1 - range/3**dist) * max_damage
		print("dist: %s" % dist)
		print("dmg: %s" % target_damage)
		node.take_damage(target_damage)
