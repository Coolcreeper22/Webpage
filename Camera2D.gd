extends Camera2D
var strengthvar = 0
var decay = 0
func _shake(strength,decaymain):
	strengthvar = strength
	decay = decaymain
func _physics_process(delta):
	offset.x = rand_range(-1.1,1.1)*strengthvar
	offset.y = rand_range(-1.1,1.1)*strengthvar
	strengthvar = move_toward(strengthvar, 0, decay)
