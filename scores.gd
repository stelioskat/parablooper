extends Node

class_name highest_score

static var hi_score = 0

func _ready():
	load_score()

static func save_score(score : int):
	if score <= hi_score:
		return
	
	# Create new ConfigFile object.
	var config = ConfigFile.new()

	# Store some values.
	config.set_value("Game", "hi_score", score)

	# Save it to a file (overwrite if already exists).
	config.save("user://scores.cfg")

static func load_score():
	var config = ConfigFile.new()

	# Load data from a file.
	var err = config.load("user://scores.cfg")

	# If the file didn't load, ignore it.
	if err != OK:
		return

	# Iterate over all sections.
	for section in config.get_sections():
		# Fetch the data for each section.
#		var player_name = config.get_value(section, "player_name")
		var player_score = config.get_value(section, "hi_score")
		hi_score = player_score
		
	return hi_score
