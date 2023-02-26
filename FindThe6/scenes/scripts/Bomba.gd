extends Area2D

func _ready():
	pass 

func _on_Timer_timeout():
	queue_free()


func _on_Bomba_body_entered(body):
	if body.name != "Player":
		$explosion2.play()
		$AnimatedSprite.hide()
		$explosion.show()
		$explosion.animation = "explo"
		$Timer.start()
		body.death()
