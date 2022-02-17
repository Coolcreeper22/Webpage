tool
extends Control


func _physics_process(delta):
	Manager.scores[0] = int($score_p1.text)
	Manager.scores[1] = int($score_p2.text)


func _p1_update(score):
	$score_p1.text = str(clamp(score + int($score_p1.text), 0, 10))
	Manager.scores[0] = clamp(score + int($score_p1.text) - 1, 0, 10)


func _p2_update(score):
	Manager.scores[1] = clamp(score + int($score_p2.text) - 1, 0, 10)
	$score_p2.text = str(clamp(score + int($score_p2.text), 0, 10))
