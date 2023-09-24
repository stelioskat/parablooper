extends Node

@export var level_scene: PackedScene

func _ready():
	var level = level_scene.instantiate()
	add_child(level)
	
func _process(delta):
	pass
	
