extends Marker2D



func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - global_position
	
	rotation = direction.angle()
	#print("Rotation:", rotation, "PI:", PI/2)
	if rotation < -PI/2 or rotation > PI/2:
		%sprPistol.flip_v = true
		%shootPoint.position.y *= -1;
	else:
		%sprPistol.flip_v = false
		
	
	

func shoot(qnt: int):
	const bullet = preload("res://scenes/playerScene/obj_bullet.tscn")
	for i in range(qnt):
		var new_bullet = bullet.instantiate()
		new_bullet.global_position = %shootPoint.global_position
		new_bullet.global_rotation = %shootPoint.global_rotation
		%shootPoint.add_child(new_bullet)
		var timer = Timer.new()
		timer.wait_time = 0.2
		timer.one_shot = true
		add_child(timer)
		timer.start()
	
