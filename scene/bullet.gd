extends KinematicBody2D

export var direction = Vector2.ZERO
export var collison_count = 0
func _ready():
	direction * 80
	$lifetime.start(10)

func _physics_process(delta):
	if position > Vector2(ProjectSettings.get("display/window/size/width"),ProjectSettings.get("display/window/size/height")):
		queue_free()
	elif position < Vector2.ZERO:
		queue_free()
	rotation = direction.angle()
	direction = direction.normalized() * 80
	
	var collision = move_and_collide(direction * delta)
	if collision:
		var reflect = collision.remainder.bounce(collision.normal)
		direction = direction.bounce(collision.normal)
		move_and_collide(reflect)
		collison_count += 1
	if Manager.reset == true or collison_count >= 50:
		queue_free()


func _on_lifetime_timeout():
	$Tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 2.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()



func _on_Tween_tween_completed(object, key):
	queue_free()


