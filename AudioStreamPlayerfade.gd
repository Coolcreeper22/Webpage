extends AudioStreamPlayer
export var speed = 0.5
func _ready():
	yield(get_tree().create_timer(.5), "timeout")
	$Tween.interpolate_property(self,"volume_db",-80,0,speed,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
