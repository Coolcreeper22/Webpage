tool
extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var texture:String
export var p_number = "p1_"
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in $GridContainer.columns:
		var button = TextureButton.new()
		button.texture_normal = load(texture)
		button.name = str(i)
		button.toggle_mode = true
		button.set_script(load("res://playerbutton.gd"))
		$GridContainer.add_child(button)

