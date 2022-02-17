extends Node2D

export var reset = false
export var scores:Array = [0,0]
export var p1_controls = 1
export var p2_controls = 2
func _process(delta):

	if scores[0] >= 10 and scores[1] >= 10:
		$CanvasLayer/Control/Label.text = "tie"
		$CanvasLayer/Control/Label.add_color_override("font_color", Color("94b0c2"))
		get_tree().paused = true
	if scores[0] >= 10 and scores[1] <10:
		$CanvasLayer/Control/Label.text = "P1 wins"
		$CanvasLayer/Control/Label.add_color_override("font_color", Color("3B5DC9"))
		get_tree().paused = true
	if scores[0] <10 and scores[1] >= 10:
		$CanvasLayer/Control/Label.text = "P2 wins"
		$CanvasLayer/Control/Label.add_color_override("font_color", Color("B13E53"))
		get_tree().paused = true
	if scores[0] <10 and scores[1] <10:
		$CanvasLayer/Control/Label.text = ""
	
	
