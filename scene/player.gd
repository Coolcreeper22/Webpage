extends KinematicBody2D

export(int) var sprite
export var player_number = 0
export var predir: Vector2 = Vector2.RIGHT
export var predir2: Vector2 = Vector2.RIGHT
export var facing = false
export var canfire = true
export var dead = false
var reset = false
export var controls = 0


func _ready():
	$arrow.rotation_degrees = rad2deg(Vector2(round(predir.x), round(predir.y)).angle())
	yield(get_tree().create_timer(.5), "timeout")
	


func _update(spriteint):
	
	spriteint = clamp(spriteint, 0, 2)
	var sprites = [
		"res://assets/buddie0 sprite sheet x1.png",
		"res://assets/buddie0 sprite sheet x2.png",
		"res://assets/buddie0 sprite sheet x3.png"
	]
	$Sprite.texture = load(sprites[spriteint])
	sprite = spriteint


func _physics_process(delta):
	
	_update(sprite)
	if player_number == 0:
		controls = Manager.p1_controls
	else:
		controls = Manager.p2_controls
	
	var direction = Vector2.ZERO
	var raw_direction = direction
	controls = clamp(controls, 0, 2)
	if controls == 0:
		if controls + get_otherplayer(player_number).controls <= 0:
			var tempdir = Vector2.ZERO
			tempdir.x = Input.get_joy_axis(player_number, 0)
			tempdir.y = Input.get_joy_axis(player_number, 1)
			if abs(tempdir.length()) >= 1:
				print(tempdir)
				direction = tempdir
				
		else:
			var tempdir = Vector2.ZERO
			tempdir.x = Input.get_joy_axis(0, 0)
			tempdir.y = Input.get_joy_axis(0, 1)
			if abs(tempdir.length()) >= 1:
				print(tempdir)
				direction = tempdir
				
			
	elif controls == 1:
		direction = Vector2(
			Input.get_action_strength("KEYD", false) - Input.get_action_strength("KEYA", false),
			Input.get_action_strength("KEYS", false) - Input.get_action_strength("KEYW", false)
		)
	elif controls == 2:
		direction = Vector2(
			(
				Input.get_action_strength("ui_right", false)
				- Input.get_action_strength("ui_left", false)
			),
			Input.get_action_strength("ui_down", false) - Input.get_action_strength("ui_up", false)
		)
	if dead != true and Manager.reset == false:
		direction = direction * 80
	else:
		direction = Vector2.ZERO
	var facingdir = Vector2.ZERO
	if controls == 0:
		if controls + get_otherplayer(player_number).controls <= 0:
			var tempdir = Vector2.ZERO
			tempdir.x = Input.get_joy_axis(player_number, 2)
			tempdir.y = Input.get_joy_axis(player_number, 3)
			if abs(tempdir.length()) >= 1:
				print(tempdir)
				facingdir = tempdir
				raw_direction = tempdir
		else:
			var tempdir = Vector2.ZERO
			tempdir.x = Input.get_joy_axis(0, 2)
			tempdir.y = Input.get_joy_axis(0, 3)
			if abs(tempdir.length()) >= 1:
				print(tempdir)
				facingdir = tempdir
				raw_direction = tempdir
	elif controls == 1:
		facingdir = Vector2(
			Input.get_action_strength("KEYD", false) - Input.get_action_strength("KEYA", false),
			Input.get_action_strength("KEYS", false) - Input.get_action_strength("KEYW", false)
		)
	elif controls == 2:
		facingdir = Vector2(
			(
				Input.get_action_strength("ui_right", false)
				- Input.get_action_strength("ui_left", false)
			),
			Input.get_action_strength("ui_down", false) - Input.get_action_strength("ui_up", false)
		)
	if round(facingdir.x) != 0:
		predir = facingdir

	if predir.x >= 0:
		facing = false
	elif predir.x < 0:
		facing = true
	if direction != Vector2.ZERO and dead == false and Manager.reset == false:
		if facing == false:
			$AnimationPlayer.play("forward")
		else:
			$AnimationPlayer.play("back")
	elif dead == false and Manager.reset == false:
		if facing != false:
			$AnimationPlayer.play("idle-left")
		else:
			$AnimationPlayer.play("idle-right")
	if Vector2(round(facingdir.x), round(facingdir.y)) != Vector2.ZERO:
		$arrow.rotation_degrees = rad2deg((raw_direction).angle())
		predir2 = Vector2(round(facingdir.x), round(facingdir.y))
	if (
		controls == 0
	
		and canfire == true
		and dead == false
		and Manager.reset == false
	):
		if controls + get_otherplayer(player_number).controls <= 0:
			if Input.is_joy_button_pressed(player_number,6) == true:
				$firerate.start(1)
				canfire = false
			
				FIRE(raw_direction)
				$AudioStreamPlayer2D.stream = load("res://scene/shoot.tres")
				$AudioStreamPlayer2D.play()
		else:
			if Input.is_joy_button_pressed(0,6) == true:
				$firerate.start(1)
				canfire = false
			
				FIRE(raw_direction)
				$AudioStreamPlayer2D.stream = load("res://scene/shoot.tres")
				$AudioStreamPlayer2D.play()
	if (
		controls == 1
		and Input.is_action_pressed("q")
		and canfire == true
		and dead == false
		and Manager.reset == false
	):
		$firerate.start(1)
		canfire = false

		FIRE(Vector2(round(predir2.x), round(predir2.y)))
		$AudioStreamPlayer2D.stream = load("res://scene/shoot.tres")
		$AudioStreamPlayer2D.play()
	if (
		controls == 2
		and Input.is_action_pressed("ctrl")
		and canfire == true
		and dead == false
		and Manager.reset == false
	):
		$firerate.start(1)
		canfire = false

		FIRE(Vector2(round(predir2.x), round(predir2.y)))
		$AudioStreamPlayer2D.stream = load("res://scene/shoot.tres")
		$AudioStreamPlayer2D.play()
	move_and_slide(direction)
	if Manager.reset == true and dead == false:
		if player_number > 0:
			position = Vector2(180, 70)
		else:
			position = Vector2(80, 70)
		if facing != true:
			$AnimationPlayer.play("idle-right")
		else:
			$AnimationPlayer.play("idle-left")


func _on_firerate_timeout():
	canfire = true


func FIRE(dir):
	var bullet = preload("res://scene/bullet.tscn").instance(PackedScene.GEN_EDIT_STATE_DISABLED)
	
	bullet.position = $"arrow/Position2D".global_position
	
	bullet.direction = dir
	get_parent().add_child(bullet)


func _on_Hit_box_controller_body_entered(body):
	body.queue_free()

	$"../../Camera2D"._shake(10, .1)
	Manager.reset = true
	dead = true
	$AudioStreamPlayer2D.stream = load("res://scene/hit.tres")
	$Particles2D.emitting = true
	$AudioStreamPlayer2D.play()

	yield(get_tree().create_timer(.1), "timeout")
	if facing != true:
		$AnimationPlayer.play("death-right")
		$arrow.hide()

	else:
		$AnimationPlayer.play("death-left")
		$arrow.hide()

	$"Hit box controller".monitoring = false
	$"Terrain collison".disabled = true
	yield(get_tree().create_timer(3), "timeout")
	if player_number > 0:
		get_node("../../score controller")._p1_update(1)
		position = Vector2(180, 70)
	else:
		get_node("../../score controller")._p2_update(1)
		position = Vector2(80, 70)
	$"Hit box controller".monitoring = true

	dead = false
	Manager.reset = false
	$"Terrain collison".disabled = false
	$arrow.show()
func get_otherplayer(playernum) -> Object:

	if playernum < 1:
		playernum = 1
	if playernum == 1:
		playernum = 0
	return get_parent().get_child(playernum)
