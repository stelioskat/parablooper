extends Node2D

func set_health(val):
	if val < 0:
		val = 0
	if val > 100:
		val = 100
		
	$HSlider.value = roundi(val)
		
