extends Node

@export var level_scene: PackedScene
var score = 0

func _ready():
	var level = level_scene.instantiate()
	level.scored.connect(_on_level_scored)
	add_child(level, false, INTERNAL_MODE_FRONT)
	
func _process(delta):
	pass
	
func _on_level_scored(points):
	score += points
	$HUD.set_score(score)
