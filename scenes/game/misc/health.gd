extends Node
class_name Health

var max_health = 100
var health = max_health

func take_damage(points):
	health -= abs(points)
	health = 0 if (health < 0) else health

func get_health():
	return health
