extends Node
class_name Health

signal health_update

var max_health = 100
var _health = max_health

func damage(points):
	if _health <= 0:
		return
		
	_health -= abs(points)
	if _health < 0:
		_health = 0
	health_update.emit(_health)

func get_health():
	return _health
