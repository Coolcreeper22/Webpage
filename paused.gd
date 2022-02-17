extends Node

func _process(delta):
	for i in get_children():
		if i.name != "0":
			if i.name != "1":
				if i.name != "2":
					i.set_physics_process(false)
					i.get_child(4).hide()
