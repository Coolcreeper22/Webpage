extends TextureButton

func _ready():
	if pressed == true:
		if $"../..".name == "pick from menu":
			Manager.p1_controls = int(self.name)
			for i in $"..".get_children():
				if i.name != self.name:
					i.pressed = false
		else:
			Manager.p2_controls = int(self.name)
			for i in $"..".get_children():
				if i.name != self.name:
					i.pressed = false

func _pressed():
	if pressed == false:
			pressed = true
	if $"../..".name == "pick from menu":
		Manager.p1_controls = int(self.name)
		for i in $"..".get_children():
			if i.name != self.name:
				i.pressed = false
	else:
		Manager.p2_controls = int(self.name)
		for i in $"..".get_children():
			if i.name != self.name:
				i.pressed = false
	
		
	
	
