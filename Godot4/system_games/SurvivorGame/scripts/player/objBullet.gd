extends Area2D

var travelled_distance = 0
const spd = 1000
const range = 1200

var damage: float = 25.0

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * spd * delta
	
	travelled_distance += spd * delta
	
	if travelled_distance >= range:
		queue_free()


func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(damage)
