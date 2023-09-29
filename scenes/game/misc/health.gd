extends Node
class_name Health

signal health_update

var max_health = 100
var health = max_health

func take_damage(points):
	if health <= 0:
		return
		
	health -= abs(points)
	if health < 0:
		health = 0
	health_update.emit(health)

func get_health():
	return health
