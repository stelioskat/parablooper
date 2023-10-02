extends Control

func set_score(score):
	$ScoreLabel.text = "Score: %s" % score

func set_hi_score(hi_score):
	$HiScoreLabel.text = "Hi-Score: %s" % hi_score
