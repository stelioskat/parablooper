extends Node2D

signal scored
signal game_over

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
	$EnemySpawnTimer.wait_time = randf_range(1, 1.5)
	var enemy = enemy_scene.instantiate()
	var side = randf_range(-1,1)
	if side < 0:
		enemy.position = Vector2(-65, randi_range(50,600))
	else:
		var width = get_viewport().get_visible_rect().size.x
		enemy.position = Vector2(width+65, randi_range(50,600))
		enemy.invert_direction()
	
	enemy.died.connect(_on_enemy_died)
	add_child(enemy)

func score(points):
	# for now we always give 1 point for each kilö
	scored.emit(points)


func _on_enemy_died():
	score(10)


func apply_damage(damage_origin : Vector2):
	# later we could use player/enemy stats or a damage/attack object :thinking:
	var max_damage = 10
	var range = 80
	
	var nodes = get_tree().get_nodes_in_group("has_health")
	for node in nodes:
		var dist = node.position.distance_to(damage_origin)
		var target_damage = 0
		if dist <= range:
			target_damage = roundi((1-dist**2/range**2) * max_damage)
		if target_damage > 0:
			node.get_node("Health").damage(target_damage)


func _on_canon_died():
	game_over.emit()
	$EnemySpawnTimer.stop()
